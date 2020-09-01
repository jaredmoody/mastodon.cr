require "../../spec_helper"

describe Mastodon::REST::FollowRequests do
  describe "#follow_requests" do
    before_each do
      stub_get("/api/v1/follow_requests", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.follow_requests.should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#authorize_follow_request" do
    before_each do
      stub_post("/api/v1/follow_requests/1/authorize")
    end

    it "is no return" do
      client.authorize_follow_request(1).should be_nil
    end
  end

  describe "#reject_follow_request" do
    before_each do
      stub_post("/api/v1/follow_requests/1/reject")
    end

    it "is no return" do
      client.reject_follow_request(1).should be_nil
    end
  end
end
