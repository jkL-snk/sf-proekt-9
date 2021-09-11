FROM python:3.8-slim-buster
COPY requirements.txt ./requirements.txt
RUN pip3 install -r ./requirements.txt
COPY app/ /svr/app/
WORKDIR /svr/app
EXPOSE 80
CMD ["python", "web.py"]
