require_relative '../../automated_init'

context "Handle Commands" do
  context "Claim" do
    context "Reserved" do
      claim_id = Identifier::UUID::Random.get

      claim = Controls::Commands::Claim.example(id: claim_id)

      Handlers::Commands.(claim)

      transaction_stream_name = "userEmailAddressTransaction-#{claim.encoded_email_address}+#{claim_id}"

      event_data, * = MessageStore::Postgres::Get.(transaction_stream_name, position: 0, batch_size: 1)

      written_message = Messaging::Message::Import.(event_data, claim.class)

      test "Claim command is written to transaction stream" do
        refute(written_message.nil?)
      end

      context "Attributes" do
        test "claim_id" do
          assert(written_message.claim_id == claim.claim_id)
        end

        test "encoded_email_address" do
          assert(written_message.encoded_email_address == claim.encoded_email_address)
        end

        test "email_address" do
          assert(written_message.email_address == claim.email_address)
        end

        test "user_id" do
          assert(written_message.user_id == claim.user_id)
        end

        test "time" do
          assert(written_message.time == claim.time)
        end
      end
    end
  end
end
