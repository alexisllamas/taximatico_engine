json.cache! driver_request do
  json.status "ok"
  json.driver_request do
    json.extract! driver_request, :id, :user_id, :driver_id, :status, :created_at, :expires_at
  end
end
