# debian based image
FROM docker.io/python:3.8-slim
RUN cat /etc/*-release
WORKDIR /app
ADD requirements.txt .
ADD 1.py .
ADD setup.sh .

USER root
RUN bash ./setup.sh

LABEL Name=ip-manager-api Version=1.1.1
EXPOSE 5000
USER 1001

CMD ["python3", "1.py"]
