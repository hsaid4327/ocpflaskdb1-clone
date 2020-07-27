FROM python:3.6
WORKDIR /opt/app-root
ADD requirements.txt .
ADD 1.py .

USER root
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo \
    && DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" \ 
    && ACCEPT_EULA=Y yum $DISABLES -y --setopt=tsflags=nodocs install msodbcsql17 \
    && yum clean all

COPY *.ini /etc
USER 1001
RUN pip install -r requirements.txt
CMD ["python","-i","1.py"]
