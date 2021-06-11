require_relative "../automated_init"

context "User Email Address" do
  context "Processed" do
    sequence = Controls::Sequence.example

    context "Has not yet processed" do
      context "User Email Address's sequence is lower than the sequence" do
        user_email_address = Controls::UserEmailAddress.example(sequence: sequence - 1)

        processed = user_email_address.processed?(sequence)

        test do
          refute(processed)
        end
      end

      context "User Email Address's sequence is nil" do
        user_email_address = Controls::UserEmailAddress.example(sequence: nil)

        processed = user_email_address.processed?(sequence)

        test do
          refute(processed)
        end
      end
    end

    context "Has processed" do
      context "User Email Address's sequence is greater than the sequence" do
        user_email_address = Controls::UserEmailAddress.example(sequence: sequence + 1)

        processed = user_email_address.processed?(sequence)

        test do
          assert(processed)
        end
      end

      context "User Email Address's sequence is equal to the sequence" do
        user_email_address = Controls::UserEmailAddress.example(sequence: sequence)

        processed = user_email_address.processed?(sequence)

        test do
          assert(processed)
        end
      end
    end
  end
end
