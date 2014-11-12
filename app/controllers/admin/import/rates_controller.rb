class Admin::Import::RatesController < Admin::ApplicationController
  def index
    @import = ::Import::Rate.new
  end

  def create
    @import = ::Import::Rate.new params[:import_rate]
    @import.perform
    flash[:notice] = 'Imported'
    redirect_to admin_import_rates_url
  end
end
