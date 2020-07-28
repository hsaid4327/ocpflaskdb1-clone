#!/bin/bash

######
###
### This Sample Code is provided for the purpose of illustration only
### and is not intended to be used in a production environment.
###
######

# setup environment variables
export ACCEPT_EULA=y
export LANG=C.UTF-8

# update base packages to latest and install basic packages
apt-get update \
&& apt-get install -y curl \
apt-transport-https \
gnupg2 \
iputils-ping \
build-essential \
libssl1.1 \
libgssapi-krb5-2

# install mssql odbc drivers
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update && apt-get install -y \
msodbcsql17 \
unixodbc \
unixodbc-dev

# Install required pip packages
python3 -m pip install -r requirements.txt

# cleanup unneeded packages for production
apt-get remove --purge -y \
curl \
apt-transport-https \
gnupg2 \
build-essential

# modify default SSL config
sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1.0/g' /etc/ssl/openssl.cnf
sed -i 's/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf

apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
