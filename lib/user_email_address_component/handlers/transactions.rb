module UserEmailAddressComponent
  module Handlers
    class Transactions
      include Log::Dependency
      include Messaging::Handle
      include Messaging::StreamName
      include Messages::Commands
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :user_email_address

      handle Claim do |claim|
        encoded_email_address = claim.encoded_email_address

        user_email_address, version = store.fetch(encoded_email_address, include: :version)

        sequence = claim.metadata.global_position

        if user_email_address.processed?(sequence)
          logger.info(tag: :ignored) { "Command ignored (Command: #{claim.message_type}, User Email Address: #{user_email_address.email_address}, User Email Address Sequence: #{user_email_address.sequence}, Claim Sequence: #{sequence}" }
          return
        end

        time = clock.iso8601

        stream_name = stream_name(encoded_email_address)

        if user_email_address.claimed?
          claim_rejected = ClaimRejected.follow(claim)
          claim_rejected.time = time
          claim_rejected.sequence = sequence

          write.(claim_rejected, stream_name, expected_version: version)

          return
        end

        claimed = Claimed.follow(claim)
        claimed.processed_time = time
        claimed.sequence = sequence

        write.(claimed, stream_name, expected_version: version)
      end
    end
  end
end
