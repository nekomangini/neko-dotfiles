{ ... }:

{
  programs.fish.shellAliases = {
    # Rails commands
    rails-c = "rails console";
    rails-s = "rails server";
    rails-g = "rails generate";
    rails-d = "rails destroy";

    # Database
    rails-db = "rails db:migrate";
    rails-dbr = "rails db:rollback";
    rails-dbs = "rails db:seed";
    rails-dbc = "rails db:create";
    rails-dbd = "rails db:drop";
    rails-dbm = "rails db:migrate:status";

    # Testing
    rail-st = "rails test";
    rail-sspec = "bundle exec rspec";

    # Bundler
    bundle-e = "bundle exec";
    bundle-i = "bundle install";
    bundle-u = "bundle update";
  };
}
