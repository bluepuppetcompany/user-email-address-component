module UserEmailAddressComponent
  module Consumers
    class Commands
      include Consumer::Postgres

      handler Handlers::Commands
    end
  end
end
