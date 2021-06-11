module UserEmailAddressComponent
  module Consumers
    class Transactions
      include Consumer::Postgres

      handler Handlers::Transactions
    end
  end
end
