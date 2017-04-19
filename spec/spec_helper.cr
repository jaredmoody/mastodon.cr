require "spec"
require "webmock"
require "../src/mastodon"

def fixture_image(name)
  File.dirname(__FILE__) + "/fixtures/#{name}"
end

def load_fixture(name)
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.json").join("\n")
end

def client
  Mastodon::REST::Client.new("mastodon.example.com", "token")
end

# GET
def stub_get(path, fixture)
  WebMock.stub(:get, "https://#{client.url}#{path}").
    with(headers: {"Authorization" => "Bearer token"}).
    to_return(body: load_fixture(fixture))
end

# POST
def stub_post(path, fixture, body = "")
  WebMock.stub(:post, "https://#{client.url}#{path}").
    with(body: body, headers: {"Content-type" => "application/x-www-form-urlencoded", "Authorization" => "Bearer token"}).
    to_return(body: load_fixture(fixture))
end

def stub_post_no_return(path, body = "")
  WebMock.stub(:post, "https://#{client.url}#{path}").
    with(body: body, headers: {"Content-type" => "application/x-www-form-urlencoded", "Authorization" => "Bearer token"}).
    to_return(body: "{}")
end
