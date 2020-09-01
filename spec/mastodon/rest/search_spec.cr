require "../../spec_helper"

describe Mastodon::REST::Search do
  describe "#search" do
    describe "with keyword" do
      before_each do
        params = HTTP::Params.build do |param|
          param.add "q", "QUERY"
        end
        stub_get("/api/v1/search", "results", params)
      end

      it "is a Mastodon::Entities::Results" do
        client.search("QUERY").should be_a Mastodon::Entities::Results
      end
    end

    describe "with account URL" do
      before_each do
        params = HTTP::Params.build do |param|
          param.add "q", "https://example.com/@USER"
        end
        stub_get("/api/v1/search", "results_account", params)
      end

      it "is a Mastodon::Entities::Results" do
        client.search("https://example.com/@USER").should be_a Mastodon::Entities::Results
      end
    end

    describe "with status URL" do
      before_each do
        params = HTTP::Params.build do |param|
          param.add "q", "https://example.com/@USER/1"
        end
        stub_get("/api/v1/search", "results_status", params)
      end

      it "is a Mastodon::Entities::Results" do
        client.search("https://example.com/@USER/1").should be_a Mastodon::Entities::Results
      end
    end
  end
end
