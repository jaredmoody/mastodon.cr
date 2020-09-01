require "../../spec_helper"

describe Mastodon::REST::Accounts do
  describe "#account" do
    before_each do
      stub_get("/api/v1/accounts/1", "account")
    end

    it "is a Mastodon::Entities::Account" do
      client.account(1).should be_a Mastodon::Entities::Account
    end
  end

  describe "#verify_credentials" do
    before_each do
      stub_get("/api/v1/accounts/verify_credentials", "account")
    end

    it "is a Mastodon::Entities::Account" do
      client.verify_credentials.should be_a Mastodon::Entities::Account
    end
  end

  describe "#update_credentials" do
    before_each do
      WebMock.stub(:patch, "https://#{client.url}/api/v1/accounts/update_credentials")
        .with(headers: default_headers)
        .to_return(body: load_fixture("account"))
    end

    it "is a Mastodon::Entities::Account" do
      client.update_credentials(display_name: "DISPLAY_NAME").should be_a Mastodon::Entities::Account
    end

    describe "without parametors" do
      it "raise HTTP::Multipart::Error" do
        expect_raises(MIME::Multipart::Error) { client.update_credentials }
      end
    end
  end

  describe "#followers" do
    before_each do
      stub_get("/api/v1/accounts/1/followers", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.followers(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#following" do
    before_each do
      stub_get("/api/v1/accounts/1/following", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.following(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#statuses" do
    before_each do
      stub_get("/api/v1/accounts/1/statuses", "statuses")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      client.statuses(1).should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute", "mute_boosts", "unmute_boosts"} %}
  describe "#" + "{{ method.id }}" do
    before_each do
      stub_post("/api/v1/accounts/1/{{ method.id }}", "relationship")
    end

    it "is a Mastodon::Entities::Relationship" do
      client.{{ method.id }}(1).should be_a Mastodon::Entities::Relationship
    end
  end
  {% end %}

  describe "#relationships" do
    before_each do
      params = HTTP::Params.build do |param|
        param.add "id[]", "1"
      end
      stub_get("/api/v1/accounts/relationships", "relationships", params)
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Relationship)" do
      client.relationships(1).should be_a Mastodon::Collection(Mastodon::Entities::Relationship)
    end
  end

  describe "#search_accounts" do
    before_each do
      params = HTTP::Params.build do |param|
        param.add "q", "name"
        param.add "limit", "10"
      end
      stub_get("/api/v1/accounts/search", "accounts", params)
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.search_accounts("name", 10).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
