module UserEmailAddressComponent
  module Messages
    module Commands
      class Claim
        include Messaging::Message

        attribute :claim_id, String
        attribute :encoded_email_address, String
        attribute :email_address, String
        attribute :user_id, String
        attribute :time, String
      end
    end
  end
end
