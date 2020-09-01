require "../../spec_helper"

describe Mastodon::REST::Blocks do
  describe "#blocks" do
    before_each do
      stub_get("/api/v1/blocks", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.blocks.should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
