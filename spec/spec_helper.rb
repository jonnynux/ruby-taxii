$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |v|
  v.cassette_library_dir = 'spec/fixtures/cassettes'
  v.hook_into :webmock
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

require 'simplecov'
SimpleCov.start

require 'taxii'
