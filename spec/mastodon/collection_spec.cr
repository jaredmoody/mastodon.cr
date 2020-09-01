require "../spec_helper"

describe Mastodon::Collection do
  accounts = Mastodon::Collection(Mastodon::Entities::Account).from_json(load_fixture("accounts"))

  describe "#from_json" do
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      accounts.should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#next_id" do
    it "is equal minimum of ids" do
      accounts.next_id.should eq 1
    end
  end

  describe "#prev_id" do
    it "is equal maximum of ids" do
      accounts.prev_id.should eq 3
    end
  end
end
