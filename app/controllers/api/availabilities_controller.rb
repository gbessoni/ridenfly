class Api::AvailabilitiesController < Api::ApplicationController
  before_action :validate_search, only: :index
  after_action :log_json_response, only: [:index, :show]

  def index
    @items  = std_collection.all + schd_collection.all
    # ActiveRecord::Associations::Preloader.new(@items, [:company, :airport]).run
  end

  def show
    @item = std_collection.find(params[:id])
  end

  protected

  def std_collection
    @std_collection ||= Availability::Collection.new search: search
  end

  def schd_collection
    @schd_collection ||= Availability::Scheduled.new search: search
  end

  def search
    @search ||= Availability::Search.new params[:search]
  end

  def validate_search
    unless search.valid?
      render json: { errors: search.errors }
      log_json_response
    end
  end
end
