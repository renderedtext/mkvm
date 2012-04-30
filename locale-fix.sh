sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales
echo "export LC_CTYPE=en_US.UTF-8" >> ~/.bash_profile
source ~/.bash_profile
