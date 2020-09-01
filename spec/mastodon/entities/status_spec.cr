require "../../spec_helper"

describe Mastodon::Entities::Status do
  status = Mastodon::Entities::Status.from_json(load_fixture("status"))

  describe "#from_json" do
    it "is a Mastodon::Entities::Status" do
      status.should be_a Mastodon::Entities::Status
    end
  end

  describe "#created_at" do
    it "is a Time" do
      status.created_at.should be_a Time
    end
  end

  describe "#account" do
    it "is a Mastodon::Entities::Account" do
      status.account.should be_a Mastodon::Entities::Account
    end
  end

  describe "#==" do
    other_status = Mastodon::Entities::Status.from_json(load_fixture("status"))

    it "equals by id" do
      status.should eq other_status
    end
  end
end
