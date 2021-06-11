module UserEmailAddressComponent
  module Controls
    module Commands
      module Claim
        def self.example(
          id: nil,
          encoded_email_address: nil,
          email_address: nil,
          user_id: nil
        )
          id ||= ID.example
          encoded_email_address ||= UserEmailAddress.encoded_email_address
          email_address ||= UserEmailAddress.email_address
          user_id ||= User.id

          claim = UserEmailAddressComponent::Messages::Commands::Claim.build

          claim.claim_id = id
          claim.encoded_email_address = encoded_email_address
          claim.email_address = email_address
          claim.user_id = user_id
          claim.time = Controls::Time::Effective.example

          claim.metadata.global_position = Position.example

          claim
        end
      end
    end
  end
end
