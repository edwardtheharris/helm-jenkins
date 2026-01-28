# syntax=docker/dockerfile:1
FROM jenkins/jenkins:latest-jdk25
LABEL org.opencontainers.image.source=https://github.com/edwardtheharris/helm-jenkins
LABEL org.opencontainers.image.description="Jenkins image"
LABEL org.opencontainers.image.licenses=MIT
USER root
RUN apt-get install -y bash git openjdk11 maven
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
CMD ["/usr/local/bin/jenkins.sh"]

FROM alpine/helm AS helm
RUN mkdir -pv /home/jenkins/agent
LABEL org.opencontainers.image.source=https://github.com/edwardtheharris/helm-jenkins
LABEL org.opencontainers.image.description="Helm runner image"
LABEL org.opencontainers.image.licenses=MIT
RUN apk add --no-cache bash bash-completion docker \
  && helm plugin install --verify=false https://github.com/helm-unittest/helm-unittest.git
CMD ["/usr/bin/helm"]
