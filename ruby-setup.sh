#!/bin/bash

apt-get update
sudo apt-get install -y build-essential zlib1g zlib1g-dev openssl libssl-dev libreadline6 libreadline6-dev

cd /tmp
wget ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p290.tar.gz
tar xvf ruby-1.9.2-p290.tar.gz
cd ruby-1.9.2-p290
./configure
make
sudo make install

cd ext/openssl
ruby extconf.rb
make
sudo make install

cd ext/readline
ruby extconf.rb
make
sudo make install
