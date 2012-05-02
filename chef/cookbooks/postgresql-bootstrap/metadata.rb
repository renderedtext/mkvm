maintainer       "Rendered Text"
maintainer_email "devs@renderedtext.com"
license          "MIT"
description      "Recipes to set up a UTF-8 cluster, create new user."
version          "0.1"
depends          "postgresql"

recipe "postgresql-bootstrap::utf8-cluster", "Sets up a UTF-8 cluster"
recipe "postgresql-bootstrap::create-user", "Creates a new database user"

%w{ ubuntu debian }.each do |os|
  supports os
end
