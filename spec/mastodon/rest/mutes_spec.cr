require "../../spec_helper"

describe Mastodon::REST::Mutes do
  describe "#mutes" do
    before_each do
      stub_get("/api/v1/mutes", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.mutes.should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
