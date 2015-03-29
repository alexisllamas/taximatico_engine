json.cache! @user do
  json.user do
    json.extract! @user, :name, :email, :username,
      :profile_picture, :authentication_token,
      :phone_number, :created_at, :updated_at
  end
end
