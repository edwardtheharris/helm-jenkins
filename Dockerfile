# syntax=docker/dockerfile:1
FROM jenkins/jenkins:latest-jdk25
USER root
RUN apt-get install -y bash git openjdk11 maven
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
CMD ["/usr/local/bin/jenkins.sh"]

FROM alpine/helm AS helm
RUN apk add --no-cache bash bash-completion
RUN helm plutin install https://github.com/helm-unittest/helm-unittest.git
CMD ["/usr/bin/helm""]
