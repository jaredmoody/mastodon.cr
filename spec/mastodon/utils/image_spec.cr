require "../../spec_helper"

describe Mastodon::Utils::Image do
  describe "#mime_type" do
    describe "with png file" do
      it "is equal `image/png`" do
        Mastodon::Utils::Image.mime_type("avatar.png").should eq "image/png"
      end
    end

    describe "with jpg file" do
      it "is equal `image/jpeg`" do
        Mastodon::Utils::Image.mime_type("avatar.jpg").should eq "image/jpeg"
      end
    end

    describe "with gif file" do
      it "is equal `image/gif`" do
        Mastodon::Utils::Image.mime_type("avatar.gif").should eq "image/gif"
      end
    end

    describe "with other" do
      it "is nil" do
        Mastodon::Utils::Image.mime_type("avatar.txt").should be_nil
      end
    end
  end
end
