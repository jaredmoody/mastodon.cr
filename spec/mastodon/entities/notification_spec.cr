require "../../spec_helper"

describe Mastodon::Entities::Notification do
  notification = Mastodon::Entities::Notification.from_json(load_fixture("notification"))

  describe "#from_json" do
    it "is a Mastodon::Entities::Notification" do
      notification.should be_a Mastodon::Entities::Notification
    end
  end

  describe "#created_at" do
    it "is a Time" do
      notification.created_at.should be_a Time
    end
  end

  describe "#account" do
    it "is a Mastodon::Entities::Account" do
      notification.account.should be_a Mastodon::Entities::Account
    end
  end
end
