module GonInitializer
  extend ActiveSupport::Concern

  included do
    before_action :init_gon
  end

  protected

  def init_gon
    gon.push(
      controller: [
        params[:controller].camelcase.gsub(
          '::','.'
        ).camelcase.split('Controller').last,
        params[:action].camelcase
      ].join('.')
    )
  end
end
