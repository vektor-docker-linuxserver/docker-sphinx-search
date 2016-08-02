FROM vektory79/i386-baseimage-ext
MAINTAINER Vektory79 <vektory79@gmail.com>

# set install packages as variable
ENV APTLIST="sphinxsearch inotify-tools"

# install packages
RUN add-apt-repository --yes  ppa:builds/sphinxsearch-rel22 && \
    apt-get update && \
    apt-get install $APTLIST -qy && \

    # cleanup
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# expose ports
EXPOSE 9312 9306

# set volumes
VOLUME /config
