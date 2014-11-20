class Api::AvailabilitiesController < Api::ApplicationController
  before_action :validate_search, only: :index

  def index
    @items = collection.all
  end

  def show
    @item = collection.find(params[:id])
  end

  protected

  def collection
    @collection ||= Availability::Collection.new search: search
  end

  def search
    @search ||= Availability::Search.new params[:search]
  end

  def validate_search
    unless search.valid?
      render json: { errors: search.errors }
    end
  end
end
