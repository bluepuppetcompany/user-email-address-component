module UserEmailAddressComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :user_email_address

    apply Claimed do |claimed|
      user_email_address.encoded_email_address = claimed.encoded_email_address
      user_email_address.email_address = claimed.email_address
      user_email_address.user_id = claimed.user_id
      user_email_address.claimed_time = Clock.parse(claimed.time)
      user_email_address.sequence = claimed.sequence
    end
  end
end
