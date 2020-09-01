require "../../spec_helper"

describe Mastodon::REST::OAuth do
  describe "#get_access_token_using_username_password" do
    before_each do
      stub_post("/oauth/token", "access_token", {
        "client_id"     => "CLIENT_ID",
        "client_secret" => "CLIENT_SECRET",
        "scope"         => "read write",
        "grant_type"    => "password",
        "username"      => "USERNAME",
        "password"      => "PASSWORD",
      })
    end

    it "is a OAuth2::AccessToken::Bearer" do
      response = client.get_access_token_using_username_password(
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        scopes: "read write",
        username: "USERNAME",
        password: "PASSWORD"
      )
      response.should be_a OAuth2::AccessToken::Bearer
    end
  end

  describe "#get_access_token_using_authorization_code" do
    before_each do
      stub_post("/oauth/token", "access_token", {
        "client_id"     => "CLIENT_ID",
        "client_secret" => "CLIENT_SECRET",
        "scope"         => "read write",
        "grant_type"    => "authorization_code",
        "code"          => "AUTHORIZATIO_CODE",
        "redirect_uri"  => "urn:ietf:wg:oauth:2.0:oob",
      })
    end

    it "is a OAuth2::AccessToken::Bearer" do
      response = client.get_access_token_using_authorization_code(
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        scopes: "read write",
        code: "AUTHORIZATIO_CODE"
      )
      response.should be_a OAuth2::AccessToken::Bearer
    end
  end

  describe "#authorize_uri" do
    it "is a valid authorize URL" do
      client.authorize_uri(client_id: "CLIENT_ID").should eq("https://example.com/oauth/authorize?client_id=CLIENT_ID&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=read")
    end
  end
end
