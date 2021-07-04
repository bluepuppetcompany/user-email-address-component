require_relative './interactive_init'

100.times do
  claim_id = Identifier::UUID::Random.get

  email_address = "jane+#{claim_id}@example.com"

  user_id = Identifier::UUID::Random.get

  Controls::Write::Claim.(
    id: claim_id,
    email_address: email_address,
    user_id: user_id
  )
end
