groupadd hadoop
useradd hadoop -g hadoop
su -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa" hadoop
