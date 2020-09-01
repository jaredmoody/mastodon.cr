require "../../spec_helper"

describe Mastodon::REST::Apps do
  describe "#apps" do
    before_each do
      stub_post("/api/v1/apps", "apps", {
        "client_name"   => "CLIENT_NAME",
        "redirect_uris" => "urn:ietf:wg:oauth:2.0:oob",
        "scopes"        => "read write follow",
        "website"       => "",
      })
    end

    it "is a Mastodon::Entities::Auth::App" do
      apps = client.apps("CLIENT_NAME", redirect_uris: "urn:ietf:wg:oauth:2.0:oob", scopes: "read write follow", website: "")
      apps.should be_a Mastodon::Entities::Auth::App
    end
  end
end
