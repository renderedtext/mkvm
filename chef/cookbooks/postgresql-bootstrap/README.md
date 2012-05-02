Recipes to set up PostgreSQL
============================

Recipes and their variables:

* `postgresql-bootstrap::utf8-cluster`: sets up UTF-8 cluster
* `postgresql-bootstrap::create-user`: creates a new database user
    + `node[:postgresql_bootstrap][:username]`
    + `node[:postgresql_bootstrap][:password]`
    + `node[:postgresql_bootstrap][:version]`
