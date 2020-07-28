# debian based image
FROM python:3.6-slim
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

