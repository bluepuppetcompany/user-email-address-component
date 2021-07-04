module UserEmailAddressComponent
  class Store
    include EntityStore

    category :user_email_address
    entity UserEmailAddress
    projection Projection
    reader MessageStore::Postgres::Read
    snapshot EntitySnapshot::Postgres, :interval => 100
  end
end
