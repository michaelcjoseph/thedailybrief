Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '191495274594818', 'f62280f7d94557097c64ca84790f3ac4'
  provider :google_oauth2, '713064586449-o24s4vqoefr3q7ik5oc0lka071libgun.apps.googleusercontent.com', 'Ck1Od258QeFftQjajIAQHJ7R'
end