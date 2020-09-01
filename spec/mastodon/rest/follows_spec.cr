require "../../spec_helper"

describe Mastodon::REST::Follows do
  describe "#follows" do
    before_each do
      forms = HTTP::Params.build do |form|
        form.add "uri", "user@domain"
      end
      stub_post("/api/v1/follows", "account", forms)
    end

    it "is a Mastodon::Entities::Account" do
      client.follows("user@domain").should be_a Mastodon::Entities::Account
    end
  end
end
