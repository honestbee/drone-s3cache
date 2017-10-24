# Cache build artifacts on s3 for drone.io
#
#     docker build --rm=true -t MacTynow/drone-s3cache .

FROM alpine:3.6
MAINTAINER MacTynow <charles.martinot@gmail.com>

RUN apk add --no-cache python py2-pip 
COPY requirements.txt /opt/drone/
WORKDIR /opt/drone
RUN  apk add --no-cache --virtual .build-dependencies python-dev libffi-dev openssl-dev build-base \ 
    && pip install -r requirements.txt \
    && apk del .build-dependencies

COPY plugin/ /opt/drone/plugin/

CMD ["python", "/opt/drone/plugin/main.py"]
