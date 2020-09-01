require "../../spec_helper"

describe Mastodon::REST::Instances do
  describe "#instance" do
    before_each do
      stub_get("/api/v1/instance", "instance")
    end

    it "is a Mastodon::Entities::Instance" do
      client.instance.should be_a Mastodon::Entities::Instance
    end
  end
end
