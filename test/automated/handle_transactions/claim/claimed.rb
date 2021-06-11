require_relative '../../automated_init'

context "Handle Transactions" do
  context "Claim" do
    context "Claimed" do
      handler = Handlers::Transactions.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      claim = Controls::Commands::Claim.example

      claim_id = claim.claim_id or fail
      encoded_email_address = claim.encoded_email_address or fail
      email_address = claim.email_address or fail
      user_id = claim.user_id or fail
      effective_time = claim.time or fail
      global_position = claim.metadata.global_position or fail

      handler.(claim)

      writer = handler.write

      claimed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Claimed)
      end

      test "Claimed Event is Written" do
        refute(claimed.nil?)
      end

      test "Written to the user email address stream" do
        written_to_stream = writer.written?(claimed) do |stream_name|
          stream_name == "userEmailAddress-#{encoded_email_address}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "claim_id" do
          assert(claimed.claim_id == claim_id)
        end

        test "encoded_email_address" do
          assert(claimed.encoded_email_address == encoded_email_address)
        end

        test "email_address" do
          assert(claimed.email_address == email_address)
        end

        test "user_id" do
          assert(claimed.user_id == user_id)
        end

        test "time" do
          assert(claimed.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(claimed.processed_time == processed_time_iso8601)
        end

        test "sequence" do
          assert(claimed.sequence == global_position)
        end
      end
    end
  end
end
