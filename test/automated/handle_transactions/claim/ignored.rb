require_relative '../../automated_init'

context "Handle Transactions" do
  context "Claim" do
    context "Ignored" do
      handler = Handlers::Transactions.new

      claim = Controls::Commands::Claim.example

      user_email_address = Controls::UserEmailAddress::Sequence.example

      assert(user_email_address.processed?(claim.metadata.global_position))

      handler.store.add(user_email_address.encoded_email_address, user_email_address)

      handler.(claim)

      writer = handler.write

      claimed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Claimed)
      end

      test "Claimed Event is not Written" do
        assert(claimed.nil?)
      end
    end
  end
end
