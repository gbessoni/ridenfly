Airbrake.configure do |config|
  config.api_key = '03fe99446612ea133427433d4ad9f70d'
  config.host    = 'devtools.naturaily.eu'
  config.port    = 80
  config.secure  = config.port == 443
end
