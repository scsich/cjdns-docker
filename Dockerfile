FROM ubuntu

# todo make this from an image that already has python in it
RUN apt-get update
# todo install python too
RUN apt-get -y install build-essential git-core curl
RUN cd /tmp; git clone https://github.com/cjdelisle/cjdns.git
RUN cd /tmp/cjdns ; ./do
RUN cp /tmp/cjdns/cjdroute /usr/bin/ ; rm -Rf /tmp/cjdns

# these are needed regardless of how cjdns is installed
RUN apt-get -y install iptables

# this is now covered in run

# RUN mkdir /dev/net ; mknod /dev/net/tun c 10 200

# this needs to launch before cjdns runs
ADD run /usr/bin/run
RUN chmod u+x /usr/bin/run
# the goal is to get a blank cjdns server up with just an admin interface...
# generates ipv6 and all keymat for box
# RUN  /usr/bin/cjdroute --genconf | /usr/bin/cjdroute --cleanconf > /etc/cjdroute.conf

# todo edit cjdns before we launch it to remove the default config


# expose cjdns port
EXPOSE 32900

# runs cjd route
CMD /usr/bin/run
