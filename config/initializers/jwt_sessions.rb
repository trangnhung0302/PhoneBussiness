JWTSessions.encryption_key = 'secret'
JWTSessions.token_store = :memory unless Rails.env.production?
JWTSessions.access_exp_time = 172_800
