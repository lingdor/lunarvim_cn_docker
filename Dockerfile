FROM ubuntu:latest
RUN sed -i -E 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install vim gcc g++ rgrep git curl make cmake gettext python pip fd-find ripgrep cargo wget -y -qq
RUN export http_proxy="http://host.docker.internal:1087"
RUN export https_proxy="http://host.docker.internal:1087"
RUN cd /usr/local/&& git clone https://github.com/neovim/neovim.git
RUN cd /usr/local/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo&&make install
RUN cd /tmp/ && wget https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh
RUN chmod u+x /tmp/install.sh
RUN LV_BRANCH='release-1.3/neovim-0.9' bash /tmp/install.sh -y && rm /tmp/install.sh
RUN echo "\nexport PATH=/root/.local/bin:$PATH" >> /root/.profile
RUN chmod u+x /root/.profile
#lunnar install todo




CMD bash 


