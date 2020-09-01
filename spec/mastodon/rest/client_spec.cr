require "../../spec_helper"

describe Mastodon::REST::Client do
  describe "#get" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .with(query: {"param1" => "1", "param2" => "2"})
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:get, "https://example.com/get")
          .with(query: {"param1" => "1", "param2" => "2"})
          .to_return(body: "ok")
      end

      it "request success" do
        client.get("/get", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#post" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:post, "https://example.com/post")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.post("/post", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#patch" do
    describe "without parametors" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch").should eq "ok"
      end
    end

    describe "with parametors string" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .with(body: "param1=1&param2=2")
          .to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch", "param1=1&param2=2").should eq "ok"
      end
    end

    describe "with parametors hash" do
      before_each do
        WebMock.stub(:patch, "https://example.com/patch")
          .with(body: "param1=1&param2=2").to_return(body: "ok")
      end

      it "request success" do
        client.patch("/patch", {"param1" => "1", "param2" => "2"}).should eq "ok"
      end
    end
  end

  describe "#delete" do
    before_each do
      WebMock.stub(:delete, "https://example.com/delete")
        .to_return(body: "ok")
    end

    it "request success" do
      client.delete("/delete").should eq "ok"
    end
  end
end
