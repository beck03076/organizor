#app/initializers/omniauth.rb
=begin
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "412836660909.apps.googleusercontent.com", "9THYqMEcuFRQtuCObnn148cQ", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.google.com/m8/feeds/',
    redirect_uri: 'http://127.0.0.1:3000/auth/google_oauth2/callback'
  }
end
=end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "853539993661-t6l5ivb9v74uddm0kaq8edvr7jilrr3b.apps.googleusercontent.com", "mLk0to63wB_1Nt5RNRQ2MoRW", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/tasks',
    redirect_uri: 'http://127.0.0.1:3000/auth/google_oauth2/callback'
  }
end

