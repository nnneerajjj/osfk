Airbrake.configure do |config|
  config.api_key = '1050d9c21caad1612cd7b52ff47145d8'
  config.host    = 'wirodi-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
