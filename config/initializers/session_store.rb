# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wtnots_session',
  :secret      => 'd4f6b40cf6b7c50e57135258706d6ce1a1965636b6a32138caac3b8897eba07e5fddef4bbd0800054c5eda8e004fc04e989ee27b3be6e459bea99b8a1399ea1f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
