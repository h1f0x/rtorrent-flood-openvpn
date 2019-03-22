FROM amd64/centos:latest

# Enabled systemd
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#VOLUME [ "/sys/fs/cgroup" ]

VOLUME [ "/config" ]
VOLUME [ "/output" ]

# copy root
COPY rootfs/ /

# OpenVPN
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y openvpn


# rTorrent
RUN yum install -y rtorrent screen psmisc
RUN useradd rtorrent -d /home/rtorrent -G wheel

# flood
RUN yum -y install gcc-c++ make mediainfo libmediainfo
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs git
RUN git clone https://github.com/jfurrow/flood.git /opt/flood
RUN cp /defaults/config/flood/config.js /opt/flood/config.js
WORKDIR /opt/flood/
RUN npm install
RUN npm install -g node-gyp
RUN npm run build
RUN useradd flood -d /home/flood -G wheel
RUN chown -R flood:flood /opt/flood/

# nginx
RUN yum install -y nginx
RUN cp -r /defaults/config/nginx/nginx.conf /etc/nginx/nginx.conf

# crontab
RUN yum install -y cronie
RUN (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/verify-external-ip.sh") | crontab -
RUN (crontab -l 2>/dev/null; echo "@reboot /usr/bin/verify-external-ip.sh") | crontab -
RUN (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/verify-services.sh") | crontab -

#configure services (systemd)
RUN systemctl enable openvpn-own-client.service
RUN systemctl enable prepare-config.service
RUN systemctl enable rtorrent.service
RUN systemctl enable flood.service
RUN systemctl enable nginx

WORKDIR /root/

# End
CMD ["/usr/sbin/init"]