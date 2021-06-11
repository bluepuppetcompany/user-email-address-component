require_relative '../../automated_init'

context "Handle Transactions" do
  context "Claim" do
    context "Expected Version" do
      handler = Handlers::Transactions.new

      claim = Controls::Commands::Claim.example

      user_email_address = Controls::UserEmailAddress::New.example

      version = Controls::Version.example

      handler.store.add(claim.encoded_email_address, user_email_address, version)

      handler.(claim)

      writer = handler.write

      claimed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Claimed)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(claimed) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
