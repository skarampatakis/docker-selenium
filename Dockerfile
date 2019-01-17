FROM ubuntu:xenial
# install required packages
RUN apt update && apt install --no-install-recommends -y unzip \
    curl \ 
    python-pip \ 
    software-properties-common \ 
    apt-transport-https \ 
    libnss3-dev \
    chromium-browser \ 
    iputils-ping

#manually install docker-ce
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

RUN apt update && apt install --no-install-recommends -y docker-ce \
    && rm -rf /var/lib/apt/lists/*

#manually install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" \ 
    -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

#TODO:getting permission denied at the moment 
#increase size of /dev/shm due to failure with crhomium for the selenium testing
#RUN echo "tmpfs /dev/shm tmpfs defaults,size=256m 0 0" >> /etc/fstab && mount -o remount tmpfs

#install chromedriver
RUN curl https://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip --output chromedriver.zip \ 
    && unzip chromedriver \
    && chmod +x chromedriver \
    && mv chromedriver /usr/local/bin/chromedriver

#install selenium   
RUN pip install selenium
