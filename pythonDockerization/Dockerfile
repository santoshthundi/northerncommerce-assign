FROM ubuntu:18.04
RUN apt-get -y update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN pip3 install flask
RUN pip3 install Flask-Cors
RUN pip3 install requests
RUN pip3 install pyyaml
COPY main.py /
COPY config.yaml /
CMD [ "python3", "main.py" ]
