require 'eventide/postgres'
require 'try'

require 'user_email_address_component/load'

require 'user_email_address_component/user_email_address'
require 'user_email_address_component/projection'
require 'user_email_address_component/store'

require 'user_email_address_component/handlers/commands'
require 'user_email_address_component/handlers/transactions'

require 'user_email_address_component/consumers/commands'
require 'user_email_address_component/consumers/transactions'

require 'user_email_address_component/start'
