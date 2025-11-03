{ ... }:

{
  programs.fish.shellAliases = {
    # Rails commands
    rc = "rails console";
    rs = "rails server";
    rg = "rails generate";
    rd = "rails destroy";

    # Database
    rdb = "rails db:migrate";
    rdbr = "rails db:rollback";
    rdbs = "rails db:seed";
    rdbc = "rails db:create";
    rdbd = "rails db:drop";
    rdbm = "rails db:migrate:status";

    # Testing
    rt = "rails test";
    rspec = "bundle exec rspec";

    # Bundler
    be = "bundle exec";
    bi = "bundle install";
    bu = "bundle update";
  };
}
