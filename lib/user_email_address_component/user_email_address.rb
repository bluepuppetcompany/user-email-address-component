module UserEmailAddressComponent
  class UserEmailAddress
    include Schema::DataStructure

    attribute :encoded_email_address, String
    attribute :email_address, String
    attribute :user_id, String
    attribute :claimed_time, Time
    attribute :sequence, Integer

    def claimed?
      !claimed_time.nil?
    end

    def processed?(message_sequence)
      return false if sequence.nil?

      sequence >= message_sequence
    end
  end
end
