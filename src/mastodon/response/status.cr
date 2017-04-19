require "json"
require "./attachment"
require "./mention"
require "./account"
require "./tag"
require "./status"

module Mastodon
  module Response
    class Status

      JSON.mapping({
        id: Int32,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        in_reply_to_id: { type: Int32, nilable: true },
        in_reply_to_account_id: { type: Int32, nilable: true },
        sensitive: { type: Bool, nilable: true },
        spoiler_text: String,
        visibility: String,
        application: { type: Mastodon::Response::Application, nilable: true },
        account: Mastodon::Response::Account,
        media_attachments: { type: Array(Mastodon::Response::Attachment), nilable: true },
        mentions: { type: Array(Mastodon::Response::Mention), nilable: true },
        tags: { type: Array(Mastodon::Response::Tag), nilable: true },
        uri: String,
        content: String,
        url: String,
        reblogs_count: Int32,
        favourites_count: Int32,
        reblog: { type: Mastodon::Response::Status, nilable: true },
        #favourited:,
        #reblogged:,
      })

      def_equals id
    end
  end
end
