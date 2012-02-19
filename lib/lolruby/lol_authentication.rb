require "lolruby/lol_base"

class LolAuthentication < Lolruby::LolBase
  def new_authentication_session
    auth_url = "http://api.cheezburger.com/xml/authenticationsession"
    post_xml(auth_url,"")
  end

  def validate_session(validation_url)
    get_lol_xml(validation_url, "AuthenticationSession")
  end

  def logout(validation_url)
    RestClient.delete(validation_url, {:DeveloperKey => api_key, :ClientID => "2165"})
  end
end