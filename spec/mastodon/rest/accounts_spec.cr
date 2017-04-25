require "../../spec_helper"

describe Mastodon::REST::Accounts do
  describe ".account(id)" do
    before do
      stub_get("/api/v1/accounts/1", "account")
    end
    subject { client.account(1) }
    it "Response should be a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe ".verify_credentials" do
    before do
      stub_get("/api/v1/accounts/verify_credentials", "account")
    end
    subject { client.verify_credentials }
    it "Response should be a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe ".update_credentials(display_name, note, avatar, header)" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "display_name", "DISPLAY_NAME"
      end
      WebMock.stub(:patch, "https://#{client.url}/api/v1/accounts/update_credentials").
        with(body: forms, headers: {"Authorization" => "Bearer token"}).
        to_return(body: load_fixture("account"))
    end
    subject { client.update_credentials("DISPLAY_NAME") }
    it "Response should be a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
    #it "Expect raise ArgumentError" do
    #  expect(update_credentials).to raise_error(ArgumentError)
    #end
  end

  describe ".followers(id, max_id, since_id, limit)" do
    before do
      stub_get("/api/v1/accounts/1/followers", "accounts")
    end
    subject { client.followers(1) }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".following(id, max_id, since_id, limit)" do
    before do
      stub_get("/api/v1/accounts/1/following", "accounts")
    end
    subject { client.following(1) }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".statuses(id, only_media, exclude_replies, max_id, since_id, limit)" do
    before do
      stub_get("/api/v1/accounts/1/statuses", "statuses")
    end
    subject { client.statuses(1) }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute"} %}
  describe ".{{ method.id }}(id)" do
    before do
      stub_post("/api/v1/accounts/1/{{ method.id }}", "relationship")
    end
    subject { client.{{ method.id }}(1) }
    it "Response should be a Mastodon::Entities::Relationship" do
      expect(subject).to be_a Mastodon::Entities::Relationship
    end
  end
  {% end %}

  describe ".relationships(ids)" do
    before do
      params = HTTP::Params.build do |param|
        param.add "id[]", "1"
      end
      query = "?#{params}" unless params.empty?
      stub_get("/api/v1/accounts/relationships#{query}", "relationships")
    end
    subject { client.relationships(1) }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Relationship)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Relationship)
    end
  end

  describe ".search_accounts(name, limit)" do
    before do
      params = HTTP::Params.build do |param|
        param.add "q", "name"
        param.add "limit", "10"
      end
      query = "?#{params}" unless params.empty?
      stub_get("/api/v1/accounts/search#{query}", "accounts")
    end
    subject { client.search_accounts("name", 10) }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
