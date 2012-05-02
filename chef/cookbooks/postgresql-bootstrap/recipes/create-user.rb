#
# Cookbook Name:: postgresql-bootstrap
# Recipe:: create-user
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

execute "create user" do
  command "psql -c \"CREATE USER #{node[:postgresql_bootstrap][:username]} WITH PASSWORD '#{node[:postgresql_bootstrap][:password]}';\" -d template1"
  user "postgres"
  action :run
  not_if %(psql -c "SELECT usename FROM pg_user" | grep "#{node[:postgresql_bootstrap][:username]}"), :user => "postgres"
end

execute "give user rights to create users and databases" do
  command "psql -c \"ALTER USER #{node[:postgresql_bootstrap][:username]} CREATEUSER CREATEDB;\" -d template1"
  user "postgres"
  action :run
end
