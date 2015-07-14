userdel -r -f hadoop
groupdel hadoop
groupadd -g 1001 hadoop
useradd hadoop -u 1001 -g hadoop
su -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa" hadoop
