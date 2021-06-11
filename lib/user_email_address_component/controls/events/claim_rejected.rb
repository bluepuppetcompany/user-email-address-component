module UserEmailAddressComponent
  module Controls
    module Events
      module ClaimRejected
        def self.example
          claim_rejected = UserEmailAddressComponent::Messages::Events::ClaimRejected.build

          claim_rejected.claim_id = ID.example
          claim_rejected.encoded_email_address = UserEmailAddress.encoded_email_address
          claim_rejected.email_address = UserEmailAddress.email_address
          claim_rejected.user_id = User.id
          claim_rejected.time = Controls::Time::Effective.example

          claim_rejected.sequence = Sequence.example

          claim_rejected
        end
      end
    end
  end
end
