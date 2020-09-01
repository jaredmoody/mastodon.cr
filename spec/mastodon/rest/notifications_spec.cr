require "../../spec_helper"

describe Mastodon::REST::Notifications do
  describe "#notifications" do
    before_each do
      stub_get("/api/v1/notifications", "notifications")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Notification)" do
      client.notifications.should be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end
  end

  describe "#notification" do
    before_each do
      stub_get("/api/v1/notifications/1", "notification")
    end

    it "is a Mastodon::Entities::Notification" do
      client.notification(1).should be_a Mastodon::Entities::Notification
    end
  end

  describe "#delete_notification" do
    before_each do
      stub_post("/api/v1/notifications/dismiss/1")
    end

    it "returns nil" do
      client.delete_notification(1).should be_nil
    end
  end

  describe "#clear_notifications" do
    before_each do
      stub_post("/api/v1/notifications/clear")
    end

    it "returns nil" do
      client.clear_notifications.should be_nil
    end
  end
end
