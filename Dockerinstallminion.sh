sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker create ubuntu:16.04
sudo docker run -i -t -d ubuntu:16.04 /bin/bash
