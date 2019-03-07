FROM docker.io/centos:7
MAINTAINER Chak Nanga "cnanga@gmail.com"

ENV RUNTIME_ENVIRONMENT="%RUNTIME_ENVIRONMENT%"
ENV BUILD_VERSION="%BUILD_VERSION%"

RUN yum -y update
RUN yum -y install wget
RUN yum -y install unzip

# Install the AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && rm awscli-bundle.zip && rm -rf awscli-bundle

# Install Oracle JRE 8
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jre-8u202-linux-x64.rpm"
RUN yum -y install jre-8u202-linux-x64.rpm
RUN rm -f jre-*.rpm

WORKDIR /opt/apps/stock-service

ADD scripts/start.sh /opt/apps/stock-service/start.sh
ADD build/libs/gs-rest-service-0.1.0.jar /opt/apps/stock-service/gs-rest-service.jar
RUN chmod 744 /opt/apps/stock-service/start.sh

EXPOSE 8080
