require "../../spec_helper"

describe Mastodon::Entities::Account do
  account = Mastodon::Entities::Account.from_json(load_fixture("account"))

  describe "#from_json" do
    it "is a Mastodon::Entities::Account" do
      account.should be_a Mastodon::Entities::Account
    end
  end

  describe "#created_at" do
    it "is a Time" do
      account.created_at.should be_a Time
    end
  end

  describe "#==" do
    other_account = Mastodon::Entities::Account.from_json(load_fixture("account"))

    it "equals by id" do
      account.should eq other_account
    end
  end
end
