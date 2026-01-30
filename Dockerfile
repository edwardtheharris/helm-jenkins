# syntax=docker/dockerfile:1
FROM jenkins/jenkins:latest-jdk25
USER root
RUN apt-get install -y bash git openjdk11 maven
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
CMD ["/usr/local/bin/jenkins.sh"]

FROM alpine/helm AS helm
USER root
RUN apk add --no-cache bash bash-completion git helm kubectl
CMD ["/bin/bash"]
