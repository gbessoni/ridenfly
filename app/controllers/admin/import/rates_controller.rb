class Admin::Import::RatesController < Admin::ApplicationController
  def index
    @import = ::Import::Rate.new
  end

  def create
    @import = ::Import::Rate.new params[:import_rate]
    @import.perform
    render action: 'index'
  end
end
