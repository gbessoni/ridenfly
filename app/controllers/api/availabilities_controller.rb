class Api::AvailabilitiesController < Api::ApplicationController
  before_action :validate_search, only: :index

  def index
    @collection = Availability::Collection.new search: search
    @items = @collection.items
  end

  protected

  def search
    @search ||= Availability::Search.new(params[:search])
  end

  def validate_search
    unless search.valid?
      render json: { errors: search.errors }
    end
  end
end
