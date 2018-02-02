
export QUESTA_HOME=/opt/questasim
#+ export QUESTA_HOME=/opt/questasim_10_5c_3_fix_upf_flash
##export PATH=$PATH:$QUESTA_HOME/bin
export PATH=$QUESTA_HOME/linux_x86_64:$PATH

export MGLS_HOME=/opt/mgls_v9-15_3-1-0.aol
export PATH=$PATH:$MGLS_HOME/bin

## can be found in /etc/rc.local
#+ $MGLS_HOME/bin/lmgrd -c /opt/license_mentor.txt
