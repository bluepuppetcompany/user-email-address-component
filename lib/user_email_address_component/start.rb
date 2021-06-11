module UserEmailAddressComponent
  class Start
    def self.build
      instance = new
      instance
    end

    def call
      Consumers::Commands.start("userEmailAddress:command")
      Consumers::Transactions.start("userEmailAddressTransaction")
    end
  end
end
