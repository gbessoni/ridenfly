class ApplicationController < ActionController::Base
  include GonInitializer

  protect_from_forgery with: :exception
end
