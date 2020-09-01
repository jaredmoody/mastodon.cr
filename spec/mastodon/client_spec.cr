require "../spec_helper"

describe Mastodon::Client do
  client = Mastodon::Client.new(url: "example.com")

  describe "#new" do
    it "is a Mastodon::Client" do
      client.should be_a Mastodon::Client
    end

    describe "#access_token" do
      context "without access token" do
        it "is nil" do
          client.access_token?.should be_nil
        end
      end

      context "with access token string" do
        it "is a OAuth2::AccessToken::Bearer" do
          client = Mastodon::Client.new(url: "example.com", access_token: "TOKEN")
          client.access_token?.should be_a OAuth2::AccessToken::Bearer
          client.access_token.access_token.should eq "TOKEN"
        end
      end

      describe "with access token object" do
        it "is a OAuth2::AccessToken::Bearer" do
          bearer_token = OAuth2::AccessToken::Bearer.new(access_token: "TOKEN", expires_in: nil)
          client = Mastodon::Client.new(url: "example.com", access_token: bearer_token)
          client.access_token?.should be_a OAuth2::AccessToken::Bearer
          client.access_token.access_token.should eq "TOKEN"
        end
      end
    end

    describe "#user_agent" do
      it "is equal `mastodon.cr/<version>`" do
        client.user_agent.should eq "mastodon.cr/#{Mastodon::VERSION}"
      end
    end
  end
end
