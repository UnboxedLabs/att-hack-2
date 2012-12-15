module ApiMacros
  def authorize_request
    before(:each) do
      api_key = ApiKey.create!
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{api_key.access_token}"
    end
  end
end