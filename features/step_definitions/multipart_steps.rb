Given /^(?:|I )send a multipart (POST|PUT) request (?:for|to) "([^"]*)" with:/ do |verb, path, body|
  body = body.hashes
  params = body.inject({}) do |hash, row|
    if row['Filename'].present?
      hash[row['Name']] = Rack::Test::UploadedFile.new(Rails.root.join('features/support/attachments/', row['Filename']), row['Type'])
    else
      hash[row['Name']] = row['Content'].strip
    end
    hash
  end
  request path, { params: params, method: verb }
end
