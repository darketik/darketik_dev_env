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

