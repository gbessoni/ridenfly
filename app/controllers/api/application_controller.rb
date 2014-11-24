class Api::ApplicationController < ApplicationController
  include ModelPaginator
  include JsonResponseLogger

  doorkeeper_for :all
end
