# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ijws_session',
  :secret      => 'c2a8f3f90a1f80809b241ca3fc5460cac37c3ab00b40dc1c32bf2c2eb8e35929a2e033a31dd3fce42555d5e3758884b52f8fc5ebdcf5572f03b41d83f8972731'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
