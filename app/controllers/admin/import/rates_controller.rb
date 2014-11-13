class Admin::Import::RatesController < Admin::ApplicationController
  def index
    @import = ::Import::Rate.new
  end

  def create
    @import = ::Import::Rate.new params[:import_rate]
    @import.perform
    set_messages
    render action: 'index'
  end

  protected

  def set_messages
    Import::RateDecorator.decorate(@import).tap do |import|
      if import.valid_objects.present?
        flash.now[:notice] = import.import_success_message
      end
      if import.invalid_objects.present?
        flash.now[:error] = import.import_error_message
      end
    end
  end
end
