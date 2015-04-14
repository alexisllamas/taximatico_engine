VCR.cucumber_tags do |t|
  t.tag '@twilio-sms'
end

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = 'features/cassettes'
end
