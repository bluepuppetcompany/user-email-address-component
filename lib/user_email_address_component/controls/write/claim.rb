module UserEmailAddressComponent
  module Controls
    module Write
      module Claim
        def self.call(
          id: nil,
          email_address: nil,
          user_id: nil
        )
          id ||= ID.example
          email_address ||= UserEmailAddress.email_address
          user_id ||= User.id

          encoded_email_address = Digest::SHA256.hexdigest(email_address.downcase)

          claim = Commands::Claim.example(
            id: id,
            encoded_email_address: encoded_email_address,
            email_address: email_address,
            user_id: user_id
          )

          command_stream_name = Messaging::StreamName.command_stream_name(encoded_email_address, "userEmailAddress")

          Messaging::Postgres::Write.(claim, command_stream_name)
        end
      end
    end
  end
end
