%w(
  ack-grep
  curl
  git-core
  g++
  libxml2-dev
  libxslt1-dev
  firefox).each do |pkg|
  package pkg do
    action :install
    options "--assume-yes"
  end
end

bash "install nodejs" do
  code <<-EOH
  apt-get update
  apt-get install --assume-yes python-software-properties
  add-apt-repository ppa:chris-lea/node.js
  apt-get --assume-yes update
  apt-get --assume-yes install nodejs
  EOH
end
