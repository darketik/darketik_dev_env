sudo yum install thunderbird.x86_64
sudo yum install xterm
sudo yum install ntfs-3g


## sublime
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo yum install sublime-text


## realvnc 
sudo rpm -Uvh VNC-Server-6.2.1-Linux-x64.rpm 

## realvnc xorg support on centos  
#  https://support.realvnc.com/Knowledgebase/Article/View/546
sudo yum install xorg-x11-drv-dummy
sudo vncinitconfig -enable-system-xorg

## cadence EDA tools fixes for centos 7
sudo yum install libXp.so.6
sudo rpm -Uvh compat-libtermcap-2.0.8-49.el6.x86_64.rpm
sudo yum install libXScrnSaver-1.2.2-6.1.el7.i686 libXScrnSaver-1.2.2-6.1.el7.x86_64

sudo chmod +x /etc/rc.d/rc.local
sudo cat "source /opt/flexlm.sh" > /etc/rc.d/rc.local

## packages install
sudo yum install -y git g++ python3-setuptools swig3.0 python3-dev libjpeg-dev libz-dev cmake lib32z1 lib32ncurses5 ant openjdk-8-jdk
sudo yum install -y python-yaml
sudo yum install -y gitk
sudo yum install -y nmap
sudo yum install -y numpy.x86_64 scipy.x86_64 python-matplotlib.x86_64 python-matplotlib-doc.x86_64 
sudo yum install -y libftdi-devel-1.1-4.el7.x86_64
sudo yum install -y libmng-1.0.10-14.el7.x86_64


sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install python36u python36u-pip python36u-devel perl-Switch.noarch
sudo easy_install-3.6 artifactory jenkinsapi sqlalchemy prettytable twisted
sudo pip3.6 install pyelftools openpyxl  xlsxwriter sphinx pexpect

## si il y a un conflit entre plusieurs version de python:
# sudo ln -s python3.6 python3
# sudo ln -s python3.6-config python3-config


sudo yum install -y libXrender-0.9.10-1.el7.i686 libXrender-0.9.10-1.el7.x86_64
sudo yum install -y libXtst-1.2.3-1.el7.i686 libXtst-1.2.3-1.el7.x86_64
sudo yum install -y libSM-1.2.2-2.el7.i686 libSM-1.2.2-2.el7.x86_64
sudo yum install -y redhat-lsb-core-4.1-27.el7.centos.1.x86_64
sudo yum install -y bash-completion bash-completion-extras

Install swig3. First get it from there and untar it:
http://www.swig.org/download.html
Then execute: ::

  $ ./configure --without-pcre
  $ make
  $ sudo make install


## maria db 10.3
# add repo
# # MariaDB 10.3 CentOS repository list - created 2018-06-20 09:34 UTC
# http://downloads.mariadb.org/mariadb/repositories/
# [mariadb]
# name = MariaDB
# baseurl = http://yum.mariadb.org/10.3/centos7-amd64
# gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
# gpgcheck=1
sudo yum install MariaDB-server MariaDB-client

sudo /etc/init.d/mysql start
#OR
# systemctl enable mysql.service
# systemctl start mysql.service

sudo mysql_upgrade
sudo mysql_secure_installation

sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent

###########################################
##install by germain to get python-config cmd
############################################
sudo yum install -y python34-devel-3.4.5-5.el7.x86_64 python34-pip-8.1.2-5.el7.noarch
sudo yum install -y python34 python34-setuptools.noarch redhat-lsb-core wget texinfo python34-devel libjpeg-turbo-devel.x86_64 ant
sudo easy_install-3.4 artifactory jenkinsapi sqlalchemy prettytable sphinx pyelftools pexpect twisted
sudo pip3.4 install pyelftools openpyxl  xlsxwriter sphinx pexpect

##### install gapuino ft2232d
# if ttyUSBx are in dialout group, add users to this group
sudo usermod -a -G dialout <username>
# create udev rule for gapuino ftdi2232 usb chip
cd /etc/udev/rules.d/
sudo touch 90-ftdi_gapuino.rules
cat 'ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0666", GROUP="dialout"'> 90-ftdi_gapuino.rules.rules
sudo udevadm control --reload-rules && sudo udevadm trigger


## install new hdd dissk on disk volume 
# http://xmodulo.com/manage-lvm-volumes-centos-rhel-7-system-storage-manager.html
sudo yum install -y system-storage-manager 
sudo ssm list 
# sudo ssm add -p <pool-name> <device> 
# sudo ssm resize -s [size (+100%FREE)] [volume] 
# 




###########################################
## openvpn server
## https://tonygillilan.com/blog/install-openvpn-on-centos-7-4-with-easy-rsa-3/
###########################################
yum -y install epel-release
yum -y install openvpn easy-rsa
yum -y install nano (text editor if needed) 

copy example server.conf file:
cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn
make changes in the conf file
nano /etc/openvpn/server.conf
port xx (or whatever, default is already in conf file)

uncomment:
tls-auth ta.key 

uncomment:
topology subnet

uncomment tcp, comment udp (tcp works best for me in my environments)

# TCP or UDP server
proto tcp
;proto udp

uncomment:
push "redirect-gateway def1 bypass-dhcp"

uncomment for multiple users to use same key pair, otherwise have to generate key pairs for each user
I prefer one key pair for all users, and then use user passwords
duplicate-cn

uncomment: needed for certain windows clients
comp-lzo 

uncomment:
user nobody
group nobody

explicit-exit-notify is only valid in UDP mode, if present with TCP profile, connection fails.
change
explicit-exit-notify 1
to
explicit-exit-notify 0

add line at end to enable users pam authentication - regular users and passwords
plugin /usr/lib64/openvpn/plugins/openvpn-plugin-auth-pam.so login

Save and exit the OpenVPN server configuration file.


Easy RSA:
mkdir /etc/openvpn/easy-rsa
cp -rf /usr/share/easy-rsa/3.0.3/* /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa

./easyrsa init-pki
./easyrsa build-ca nopass
hit enter
./easyrsa gen-req server1 nopass
hit enter
./easyrsa gen-req client1 nopass
hit enter
./easyrsa sign-req client client1
type yes
./easyrsa sign-req server server1
type yes
./easyrsa gen-dh
wait awhile

go to server conf and put paths to keys etc
nano /etc/openvpn/server.conf
search for "ca ca.crt" to locate line
ca /etc/openvpn/easy-rsa/pki/ca.crt
cert /etc/openvpn/easy-rsa/pki/issued/server1.crt
key /etc/openvpn/easy-rsa/pki/private/server1.key
then right below that

location of dh:
dh /etc/openvpn/easy-rsa/pki/dh.pem
save and exit the conf file

nano /etc/sysctl.conf

addd the following line:
net.ipv4.ip_forward = 1

systemctl restart network.service

open port in firewall with the same port you chose above
firewall-cmd --zone=myzone --permanent --add-port=1194/tcp   <==== or whatever port you setup (shows myzone, but use whatever zone you are using
firewall-cmd --permanent --add-masquerade
firewall-cmd --reload

systemctl -f enable openvpn@server.service
systemctl start openvpn@server.service

Download the following from the server

/etc/openvpn/easy-rsa/pki/ca.crt
/etc/openvpn/easy-rsa/pki/issued/client1.crt
/etc/openvpn/easy-rsa/pki/private/client1.key

cp /usr/share/doc/openvpn-2.4.6/sample/sample-config-files/client.conf .

============= start of file ========do not include this line======remove notes=====
client
dev tun
proto tcp <=== change protocall?
remote 45.79.70.57 53  <== connection info here
port 53 <===== only add this line if other than default port of 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
cipher AES-256-CBC
auth-user-pass



