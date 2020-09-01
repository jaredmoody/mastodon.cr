require "../../spec_helper"

describe Mastodon::Utils::MultipartFormData do
  filename = fixture_image("icon.png")
  file = File.open(filename, "rb")

  multipart = Mastodon::Utils::MultipartFormData.new
  multipart.add_file("file", File.basename(filename), file)
  multipart.finish

  describe "#content_type" do
    it "is match multipart/form-data; boundary=..." do
      multipart.content_type.should match /^multipart\/form-data; boundary=/
    end
  end

  describe "#size" do
    it "is equal IO size" do
      multipart.size.should eq multipart.io.size
    end
  end
end
