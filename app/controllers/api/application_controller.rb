class Api::ApplicationController < ApplicationController
  include ModelPaginator
  include JsonResponseLogger
end
