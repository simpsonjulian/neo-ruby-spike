require 'rubygems'
require 'bundler'

Bundler.require

load 'neo4j/tasks/neo4j_server.rake'
load 'neo4j/tasks/migration.rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end