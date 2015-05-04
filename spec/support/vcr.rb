VCR.configure do |config|
  config.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  config.ignore_hosts 'codeclimate.com'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
