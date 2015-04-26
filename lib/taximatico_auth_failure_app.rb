class TaximaticoAuthFailureApp < Devise::FailureApp
  def respond
    if request.format == :json or request.content_type == 'application/json' # == :json does not works here
      json_failure
    else
      super
    end
  end

  def json_failure
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { status: "error", error: "auth_token_not_present_or_invalid" }.to_json
  end
end
