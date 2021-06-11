require_relative "../automated_init"

context "User Email Address" do
  context "Has Claimed Time" do
    user_email_address = Controls::UserEmailAddress::Claimed.example

    test "Is claimed" do
      assert(user_email_address.claimed?)
    end
  end

  context "Does not Have Claimed Time" do
    user_email_address = Controls::UserEmailAddress::New.example

    test "is not claimed" do
      refute(user_email_address.claimed?)
    end
  end
end
