require "../../spec_helper"

describe Mastodon::REST::Media do
  describe "#media_upload" do
    before_each do
      WebMock.stub(:post, "https://#{client.url}/api/v1/media")
        .with(headers: default_headers)
        .to_return(body: load_fixture("attachment"))
    end

    it "is a Mastodon::Entities::Attachment" do
      response = client.media_upload(fixture_image("icon.png"))
      response.should be_a Mastodon::Entities::Attachment
      response.meta.should be_a Hash(String, Mastodon::Entities::Attachment::MetaData)
    end

    describe "with invalid file" do
      it "raise ArgumentError" do
        expect_raises(ArgumentError) { client.media_upload(fixture_image("foo.png")) }
      end
    end
  end
end
