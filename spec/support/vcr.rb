VCR.configure do |config|
  config.cassette_library_dir = "support/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
