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

    module Transform
      def self.instance(raw_data)
        raw_data[:claimed_time] = Time.parse(raw_data[:claimed_time])
        UserEmailAddress.build(raw_data)
      end

      def self.raw_data(instance)
        raw_data = instance.to_h
        raw_data[:claimed_time] = Clock.iso8601(raw_data[:claimed_time])
        raw_data
      end
    end
  end
end
