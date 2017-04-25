require "json"
require "./attachment"
require "./mention"
require "./account"
require "./tag"
require "./status"

module Mastodon
  module Entities
    class Status

      JSON.mapping({
        id: Int32,
        uri: String,
        url: String,
        account: Entities::Account,
        in_reply_to_id: { type: Int32, nilable: true },
        in_reply_to_account_id: { type: Int32, nilable: true },
        reblog: { type: Entities::Status, nilable: true },
        content: String,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        reblogs_count: Int32,
        favourites_count: Int32,
        # reblogged: { type: Bool, nilable: true },
        # favourited: { type: Bool, nilable: true },
        sensitive: { type: Bool, nilable: true },
        spoiler_text: String,
        visibility: String, # public, unlisted, private, direct
        media_attachments: { type: Array(Entities::Attachment), nilable: true },
        mentions: { type: Array(Entities::Mention), nilable: true },
        tags: { type: Array(Entities::Tag), nilable: true },
        application: { type: Entities::Application, nilable: true },
      })

      def_equals id
    end
  end
end
