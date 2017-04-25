require "../../spec_helper"

describe Mastodon::Entities::Notification do
  describe "initialize from JSON" do
    subject { Mastodon::Entities::Notification.from_json(load_fixture("notification")) }

    it "should be a Mastodon::Entities::Notification" do
      expect(subject).to be_a Mastodon::Entities::Notification
    end

    it ".created_at should be a Time" do
      expect(subject.created_at).to be_a Time
    end

    it ".account should be a Mastodon::Entities::Account" do
      expect(subject.account).to be_a Mastodon::Entities::Account
    end
  end

  describe "initialize from JSON array" do
    subject {  Mastodon::Collection(Mastodon::Entities::Notification).from_json(load_fixture("notifications")) }

    it "should be a Mastodon::Collection(Mastodon::Entities::Notification)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end

    it ".next_id and .prev_id" do
      expect(subject.next_id).to eq 1
      expect(subject.prev_id).to eq 3
    end
  end
end
