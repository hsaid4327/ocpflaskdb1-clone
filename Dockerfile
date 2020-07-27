FROM python:3.6
WORKDIR /opt/app-root
ADD requirements.txt .
ADD 1.py .

USER root
RUN curl https://packages.microsoft.com/config/rhel/6/prod.repo > /etc/yum.repos.d/mssql-release.repo && \
    curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo && \
    curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo
RUN ACCEPT_EULA=Y yum -y --setopt=tsflags=nodocs install msodbcsql17 && \
                 yum -y --setopt=tsflags=nodocs install unixODBC && \
                 yum install -y --setopt=tsflags=nodocs unixODBC-devel && \
                 yum clean all

COPY *.ini /etc
USER 1001
RUN pip install -r requirements.txt
CMD ["python","-i","1.py"]
