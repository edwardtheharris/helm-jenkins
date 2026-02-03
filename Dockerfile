# syntax=docker/dockerfile:1
FROM jenkins/jenkins:latest AS jenkins
LABEL org.opencontainers.image.source=https://github.com/edwardtheharris/helm-jenkins
LABEL org.opencontainers.image.description="Jenkins image"
LABEL org.opencontainers.image.licenses=MIT
USER root
RUN printf "Install helm." \
  && apt-get update \
  && apt-get install -y apt-transport-https ca-certificates curl gnupg sudo
RUN sudo apt-get install curl gpg apt-transport-https --yes \
  && curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
  && sudo apt-get update \
  && sudo apt-get install helm
RUN printf "Install Kubernetes" \
  && curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
  && sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring \
  && echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list \
  && sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly \
  && apt-get update \
  && apt-get install -y bash bash-completion git helm maven python3 kubectl
USER jenkins
EXPOSE 8080
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
CMD ["/usr/local/bin/jenkins.sh"]

FROM jenkins/inbound-agent:latest AS jnlp
LABEL org.opencontainers.image.source=https://github.com/edwardtheharris/helm-jenkins
LABEL org.opencontainers.image.description="JNLP Container"
LABEL org.opencontainers.image.licenses=MIT
EXPOSE 50000
WORKDIR /home/jenkins/agent
CMD ["/usr/local/bin/jenkins-agent"]


FROM jenkins/inbound-agent AS helm
LABEL org.opencontainers.image.source=https://github.com/edwardtheharris/helm-jenkins
LABEL org.opencontainers.image.description="Helm runner image"
LABEL org.opencontainers.image.licenses=MIT
WORKDIR /home/jenkins/agent
USER root
RUN apt-get -y update \
  && apt-get -y install bash-completion python3 python3.13-venv sudo
RUN sudo apt-get install curl gpg apt-transport-https --yes \
  && curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
  && sudo apt-get update \
  && sudo apt-get install helm \
  && helm plugin install https://github.com/helm-unittest/helm-unittest.git \
  && python3 -m venv . \
  && bin/python3 -m pip install --no-cache-dir -U pip httpie \
  && ln -sfv "$(pwd)/bin/http" /usr/bin/http
ENTRYPOINT ["/bin/bash"]
