# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_paydemo_session',
  :secret      => '756b5adb5fedf527f0aa848010e829a31fd25b3d8cf77aa3cb73a4af4d51c9581f5293116ff92c0368b93f16b3e50bf62d0ca25dcf06cdab9b78a09cc68e24b6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
