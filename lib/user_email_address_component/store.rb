module UserEmailAddressComponent
  class Store
    include EntityStore

    category :user_email_address
    entity UserEmailAddress
    projection Projection
    reader MessageStore::Postgres::Read
  end
end
