home_dir = File.expand_path(File.dirname(__FILE__) + "/..")
file_cache_path  home_dir
cookbook_path [ "#{home_dir}/cookbooks" ]
