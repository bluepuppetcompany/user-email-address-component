require_relative './interactive_init'

claim_id = "aaa"

email_address = "jane@example.com"

user_id = "123"

Controls::Write::Claim.(
  id: claim_id,
  email_address: email_address,
  user_id: user_id
)
