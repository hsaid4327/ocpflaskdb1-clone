FROM python:3.6
WORKDIR /opt/app-root
ADD requirements.txt .
ADD 1.py .

USER root
RUN curl https://packages.microsoft.com/config/rhel/6/prod.repo > /etc/yum.repos.d/mssql-release.repo 
RUN ACCEPT_EULA=Y yum  install e2fsprogs \
                  && yum install msodbcsql17 \
                  && yum clean all

COPY *.ini /etc
USER 1001
RUN pip install -r requirements.txt
CMD ["python","-i","1.py"]
