module UserEmailAddressComponent
  module Controls
    module Events
      module Claimed
        def self.example
          claimed = UserEmailAddressComponent::Messages::Events::Claimed.build

          claimed.claim_id = ID.example
          claimed.encoded_email_address = UserEmailAddress.encoded_email_address
          claimed.email_address = UserEmailAddress.email_address
          claimed.user_id = User.id
          claimed.time = Controls::Time::Effective.example
          claimed.processed_time = Controls::Time::Processed.example

          claimed.sequence = Sequence.example

          claimed
        end
      end
    end
  end
end
