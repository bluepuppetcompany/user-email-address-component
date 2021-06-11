require_relative '../../automated_init'

context "Handle Transactions" do
  context "Claim" do
    context "Claim Rejected" do
      handler = Handlers::Transactions.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      user_email_address = Controls::UserEmailAddress::Claimed.example

      handler.store.add(user_email_address.encoded_email_address, user_email_address)

      claim = Controls::Commands::Claim.example

      claim_id = claim.claim_id or fail
      encoded_email_address = claim.encoded_email_address or fail
      email_address = claim.email_address or fail
      user_id = claim.user_id or fail
      effective_time = claim.time or fail
      global_position = claim.metadata.global_position or fail

      handler.(claim)

      writer = handler.write

      claim_rejected = writer.one_message do |event|
        event.instance_of?(Messages::Events::ClaimRejected)
      end

      test "Claim Rejected Event is Written" do
        refute(claim_rejected.nil?)
      end

      test "Written to the user email address stream" do
        written_to_stream = writer.written?(claim_rejected) do |stream_name|
          stream_name == "userEmailAddress-#{encoded_email_address}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "claim_id" do
          assert(claim_rejected.claim_id == claim_id)
        end

        test "encoded_email_address" do
          assert(claim_rejected.encoded_email_address == encoded_email_address)
        end

        test "email_address" do
          assert(claim_rejected.email_address == email_address)
        end

        test "user_id" do
          assert(claim_rejected.user_id == user_id)
        end

        test "time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(claim_rejected.time == processed_time_iso8601)
        end

        test "sequence" do
          assert(claim_rejected.sequence == global_position)
        end
      end
    end
  end
end
