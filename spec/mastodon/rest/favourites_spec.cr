require "../../spec_helper"

describe Mastodon::REST::Favourites do
  describe "#favourites" do
    before_each do
      stub_get("/api/v1/favourites", "statuses")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      client.favourites.should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end
end
