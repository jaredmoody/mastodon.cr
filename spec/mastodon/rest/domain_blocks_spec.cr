require "../../spec_helper"

describe Mastodon::REST::DomainBlocks do
  describe "#domain_blocks" do
    before_each do
      stub_get("/api/v1/domain_blocks", "domain_blocks")
    end

    it "is a Array(String)" do
      client.domain_blocks.should be_a Array(String)
    end
  end

  describe "#block_domain" do
    before_each do
      forms = HTTP::Params.build do |form|
        form.add "domain", "some.domain"
      end
      stub_post("/api/v1/domain_blocks", "domain_blocks", forms)
    end

    it "returns nil" do
      client.block_domain("some.domain").should be_nil
    end
  end

  describe "#unblock_domain" do
    before_each do
      forms = HTTP::Params.build do |form|
        form.add "domain", "some.domain"
      end
      WebMock.stub(:delete, "https://#{client.url}/api/v1/domain_blocks")
        .with(body: forms, headers: default_headers)
        .to_return(body: "{}")
    end

    it "returns nil" do
      client.unblock_domain("some.domain").should be_nil
    end
  end
end
