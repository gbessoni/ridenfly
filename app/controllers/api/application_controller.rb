class Api::ApplicationController < ApplicationController
  include ModelPaginator
  include JsonResponseLogger

  protect_from_forgery with: :null_session

  doorkeeper_for :all
end
