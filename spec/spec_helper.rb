require 'simplecov'
SimpleCov.profiles.define 'rdf_resource' do
  add_filter '.binstubs'
  add_filter '.bundle'
  add_filter 'bin'
  add_filter 'pkg'
  add_filter 'spec'
  add_filter 'vendor'
  # Simplecov can detect changes using data from the
  # last rspec run.  Travis will never have a previous
  # dataset for comparison, so it can't fail a travis build.
  maximum_coverage_drop 0.1
end
SimpleCov.start 'rdf_resource'

require 'rdf-resource'
require 'rspec'
RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

