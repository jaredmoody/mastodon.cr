require "../../spec_helper"

describe Mastodon::REST::Statuses do
  describe "#status" do
    before_each do
      stub_get("/api/v1/statuses/1", "status")
    end

    it "is a Mastodon::Entities::Status" do
      client.status(1).should be_a Mastodon::Entities::Status
    end
  end

  describe "#create_status" do
    before_each do
      forms = HTTP::Params.build do |form|
        form.add "status", "Hello world"
      end
      stub_post("/api/v1/statuses", "status", forms)
    end

    it "is a Mastodon::Entities::Status" do
      client.create_status("Hello world").should be_a Mastodon::Entities::Status
    end
  end

  describe "#delete_status" do
    before_each do
      WebMock.stub(:delete, "https://#{client.url}/api/v1/statuses/1")
        .with(headers: default_headers)
        .to_return(body: "{}")
    end

    it "is no return" do
      client.delete_status(1).should be_nil
    end
  end

  describe "#card" do
    before_each do
      stub_get("/api/v1/statuses/1/card", "card")
    end

    it "is a Mastodon::Entities::Card" do
      client.card(1).should be_a Mastodon::Entities::Card
    end
  end

  describe "#context" do
    before_each do
      stub_get("/api/v1/statuses/1/context", "context")
    end

    it "is a Mastodon::Entities::Context" do
      client.context(1).should be_a Mastodon::Entities::Context
    end
  end

  {% for method in {"reblogged_by", "favourited_by"} %}
  describe "#" + "{{ method.id }}" do
    before_each do
      stub_get("/api/v1/statuses/1/{{ method.id }}", "accounts")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      client.{{ method.id }}(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
  {% end %}

  {% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
  describe "#" + "{{ method.id }}" do
    before_each do
      stub_post("/api/v1/statuses/1/{{ method.id }}", "status")
    end

    it "is a Mastodon::Entities::Status" do
      client.{{ method.id }}(1).should be_a Mastodon::Entities::Status
    end
  end
  {% end %}
end
