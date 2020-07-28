FROM python:3
WORKDIR /app
ADD requirements.txt .
ADD 1.py .

# install FreeTDS and dependencies
USER root
RUN yum update \
 && ACCEPT_EULA=Y yum install unixodbc -y \
 && ACCEPT_EULA=Y yum install unixodbc-dev -y \
 && ACCEPT_EULA=Y yum install freetds-dev -y \
 && ACCEPT_EULA=Y yum install freetds-bin -y \
 && ACCEPT_EULA=Y yum install tdsodbc -y \
 && ACCEPT_EULA=Y yum install --reinstall build-essential -y
# populate "ocbcinst.ini" as this is where ODBC driver config sits
RUN echo "[FreeTDS]\n\
Description = FreeTDS Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini
#Pip command without proxy setting
USER 1001
RUN pip install -r requirements.txt
CMD ["python","-i","1.py"]
