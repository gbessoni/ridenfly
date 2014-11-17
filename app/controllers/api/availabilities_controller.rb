class Api::AvailabilitiesController < Api::ApplicationController
  def index
    @collection = Availability::Collection.new search: search
    @items = @collection.items
  end

  protected

  def search
    Availability::Search.new(params[:search])
  end
end
