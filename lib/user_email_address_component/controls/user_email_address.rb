module UserEmailAddressComponent
  module Controls
    module UserEmailAddress
      def self.example(sequence: nil)
        user_email_address = UserEmailAddressComponent::UserEmailAddress.build

        user_email_address.encoded_email_address = encoded_email_address

        user_email_address.sequence = sequence unless sequence.nil?

        user_email_address
      end

      def self.encoded_email_address
        downcased_email_address = email_address.downcase
        Digest::SHA256.hexdigest(downcased_email_address)
      end

      def self.email_address
        "jane@example.com"
      end

      module New
        def self.example
          UserEmailAddressComponent::UserEmailAddress.build
        end
      end

      module Claimed
        def self.example
          user_email_address = UserEmailAddress.example
          user_email_address.claimed_time = Time::Effective::Raw.example
          user_email_address
        end
      end
    end
  end
end
