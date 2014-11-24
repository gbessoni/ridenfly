class Admin::AppsController < Doorkeeper::ApplicationsController
  layout 'application'

  def index
    @applications = Doorkeeper::Application.paginate(page: params[:page], per_page: 10)
  end

  def create
    @application = Doorkeeper::Application.new(application_params)
    @application.owner ||= current_user

    if @application.save
      flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  private

  def application_params
    params.require(:application).permit(
      :name, :redirect_uri, :uid, :secret
    ).tap do |params|
      [:uid, :secret].each do |name|
        params.delete(name) if params[name].blank?
      end
    end
  end
end
