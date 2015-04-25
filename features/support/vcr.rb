VCR.cucumber_tags do |t|
  t.tag '@twilio-sms'
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
end
