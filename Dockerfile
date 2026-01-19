# syntax=docker/dockerfile:1
FROM jenkins/jenkins:latest-jdk25
USER root
RUN apt-get install -y bash git openjdk11 maven
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
CMD ["/usr/local/bin/jenkins.sh"]
