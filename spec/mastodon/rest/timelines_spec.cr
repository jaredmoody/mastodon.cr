require "../../spec_helper"

describe Mastodon::REST::Timelines do
  describe "#timeline_home" do
    before_each do
      stub_get("/api/v1/timelines/home", "statuses")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      client.timeline_home.should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe "#timeline_public" do
    before_each do
      stub_get("/api/v1/timelines/public", "statuses")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      client.timeline_public.should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe "#timeline_tag" do
    before_each do
      stub_get("/api/v1/timelines/tag/hashtag", "statuses")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      client.timeline_tag("hashtag").should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end
end
