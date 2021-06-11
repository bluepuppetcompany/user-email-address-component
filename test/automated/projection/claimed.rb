require_relative '../automated_init'

context "Projection" do
  context "Claimed" do
    user_email_address = Controls::UserEmailAddress::New.example

    assert(user_email_address.claimed_time.nil?)

    claimed = Controls::Events::Claimed.example

    encoded_email_address = claimed.encoded_email_address or fail
    email_address = claimed.email_address or fail
    user_id = claimed.user_id or fail
    claimed_time_iso8601 = claimed.time or fail
    sequence = claimed.sequence or fail

    Projection.(user_email_address, claimed)

    test "Encoded Email Address is set" do
      assert(user_email_address.encoded_email_address == claimed.encoded_email_address)
    end

    test "Email Address is set" do
      assert(user_email_address.email_address == claimed.email_address)
    end

    test "User ID is set" do
      assert(user_email_address.user_id == claimed.user_id)
    end

    test "Claimed time is converted and copied" do
      claimed_time = Time.parse(claimed_time_iso8601)

      assert(user_email_address.claimed_time == claimed_time)
    end

    test "Sequence is set" do
      assert(user_email_address.sequence == claimed.sequence)
    end
  end
end
