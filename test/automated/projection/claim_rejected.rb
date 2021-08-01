require_relative '../automated_init'

context "Projection" do
  context "Claim Rejected" do
    user_email_address = Controls::UserEmailAddress::Claimed.example

    claim_rejected = Controls::Events::ClaimRejected.example

    sequence = claim_rejected.sequence or fail

    Projection.(user_email_address, claim_rejected)

    test "Sequence is set" do
      assert(user_email_address.sequence == sequence)
    end
  end
end
