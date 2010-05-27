# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_voicenowtter_session',
  :secret      => '9b4bc4eac47ccf9c9350ff4f698b44ebdc3643b2ed06e3690e3bcc0d41f126563b7fc534fd9e061ad8ca53b67bae6cbfd8c5810cfc413be9dc9d53fdf8f0d361'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
