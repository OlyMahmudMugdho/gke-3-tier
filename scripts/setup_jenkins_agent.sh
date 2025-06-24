#!/bin/bash
sudo apt update && \
curl -fsSL https://get.docker.com -o get-docker.sh && \
sh get-docker.sh && \
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
chmod +x kubectl && \
mkdir -p ~/.local/bin && \
mv ./kubectl ~/.local/bin/kubectl && \
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc && \
wget https://get.helm.sh/helm-v3.18.3-linux-amd64.tar.gz && \
tar -xvf helm-v3.18.3-linux-amd64.tar.gz && \
sudo mv linux-amd64/helm /usr/local/bin/helm && \
sudo usermod -aG docker $USER && newgrp docker && \
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz && \
tar -xf google-cloud-cli-linux-x86_64.tar.gz && \
source ~/.bashrc
