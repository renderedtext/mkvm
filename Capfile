role :app, ENV["SERVER"]

set :user, ENV["USER"]
set :port, ENV["PORT"]

set(:locale_fix_script_path) { "/home/#{user}/locale-fix.sh" }
set(:ruby_setup_script_path) { "/home/#{user}/ruby-setup.sh" }
set(:rubygems_setup_script_path) { "/home/#{user}/rubygems-setup.sh" }
set(:chef_dir) { "/home/#{user}/chef" }

default_run_options[:pty] = true #for nicer output (progress bars etc)

def upload_and_run(local_path, remote_path)
  upload local_path, remote_path
  run "chmod a+x #{remote_path}"
  sudo remote_path
  sudo "rm #{remote_path}"
end

desc "fixes locale"
task :fix_locale do
  sudo "locale-gen en_US en_US.UTF-8"
  sudo "dpkg-reconfigure locales"
  run "echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.bash_profile"
end

desc "Install ruby"
task :install_ruby do
  upload_and_run "ruby-setup.sh", ruby_setup_script_path
end

desc "Install rubygems"
task :install_rubygems do
  upload_and_run "rubygems-setup.sh", rubygems_setup_script_path
end

desc "Install required gems"
task :install_required_gems do
  sudo "gem install chef --no-ri --no-rdoc"
  sudo "gem install bundler --no-ri --no-rdoc"
end

desc "Upload cookbooks"
task :upload_cookbooks do
  run "rm -rf #{chef_dir}"
  run "mkdir -p #{chef_dir}"
  upload("./chef/cookbooks", "#{chef_dir}", :via => :scp, :recursive => true)
  upload("./chef/config", "#{chef_dir}", :via => :scp, :recursive => true)
end

def run_chef_configuration
  sudo "chef-solo -j #{chef_dir}/config/main.json -c #{chef_dir}/config/solo.rb"
end

desc "Install application stack"
task :install_stack do
  #fix_locale
  install_ruby
  install_rubygems
  install_required_gems
  upload_cookbooks
  run_chef_configuration
end
