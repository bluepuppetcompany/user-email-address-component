module UserEmailAddressComponent
  module Handlers
    class Commands
      include Log::Dependency
      include Messaging::Handle
      include Messaging::StreamName
      include Messages::Commands
      include Messages::Events

      dependency :write, Messaging::Postgres::Write

      def configure
        Messaging::Postgres::Write.configure(self)
      end

      category :user_email_address

      handle Claim do |claim|
        transaction_stream_name = stream_name(
          claim.claim_id,
          "userEmailAddressTransaction",
          cardinal_id: claim.encoded_email_address
        )

        claim = Claim.follow(claim)

        Try.(MessageStore::ExpectedVersion::Error) do 
          write.initial(claim, transaction_stream_name)
        end
      end
    end
  end
end
