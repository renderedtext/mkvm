#
# Cookbook Name:: postgresql-bootstrap
# Recipe:: utf8-cluster
#
# Copyright 2011, Rendered Text
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

execute "alter user postgresql" do
  command "psql -c \"ALTER USER postgres\" -d template1"
  user "postgres"
  action :run
  not_if %(psql -l | grep "UTF"), :user => "#{node[:postgresql_bootstrap][:username]}"
end

execute "drop default cluster" do
  command "pg_dropcluster --stop #{node[:postgresql_bootstrap][:version]} main"
  user "postgres"
  action :run
  not_if %(psql -l | grep "UTF"), :user => "#{node[:postgresql_bootstrap][:username]}"
end

execute "re-create default cluster" do
  command "su - postgres -c \"pg_createcluster --start -e UTF-8 #{node[:postgresql_bootstrap][:version]} main\""
  action :run
  not_if %(psql -l | grep "UTF"), :user => "#{node[:postgresql_bootstrap][:username]}"
end
