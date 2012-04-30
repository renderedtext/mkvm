#!/bin/bash

wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
tar -xzvf rubygems-1.8.24.tgz
cd rubygems-1.8.24 && sudo ruby setup.rb
cd ..
rm rubygems-1.8.24.tgz
rm -rf rubygems-1.8.24
