json.cache! @request do
  json.status "ok"
  json.request do
    json.extract! @request, :id, :user_id, :created_at, :expires_at
  end
end
