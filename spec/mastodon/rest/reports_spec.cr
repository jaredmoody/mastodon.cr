require "../../spec_helper"

describe Mastodon::REST::Reports do
  describe "#reports" do
    before_each do
      stub_get("/api/v1/reports", "reports")
    end

    it "is a Mastodon::Collection(Mastodon::Entities::Report)" do
      client.reports.should be_a Mastodon::Collection(Mastodon::Entities::Report)
    end
  end

  describe "#report" do
    before_each do
      forms = HTTP::Params.build do |form|
        form.add "account_id", "1"
        form.add "status_ids[]", "1"
        form.add "status_ids[]", "2"
        form.add "status_ids[]", "3"
        form.add "comment", ""
      end
      stub_post("/api/v1/reports", "report", forms)
    end

    it "is a Mastodon::Entities::Report" do
      client.report(1, [1, 2, 3], "").should be_a Mastodon::Entities::Report
    end
  end
end
