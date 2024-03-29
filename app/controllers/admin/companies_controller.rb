class Admin::CompaniesController < Admin::ApplicationController
  before_action :set_admin_company, only: [:show, :edit, :update, :destroy]
  require_role :admin

  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @q = Company.ransack(params[:q])
    @companies = paginate_model @q.result.includes(:user).order(:name)
  end

  # GET /admin/companies/1
  # GET /admin/companies/1.json
  def show
  end

  # GET /admin/companies/new
  def new
    @company = Company.new user: User.new
  end

  # GET /admin/companies/1/edit
  def edit
  end

  # POST /admin/companies
  # POST /admin/companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        @company.user.add_role User::COMPANY
        format.html { redirect_to [:admin, @company], notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/companies/1
  # PATCH/PUT /admin/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to [:admin, @company], notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/companies/1
  # DELETE /admin/companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(
        :name, :contact_first_name, :contact_last_name, :email, :address, :street, :state, :zipcode, :no_pickup_message,
        :phone, :mobile, :dispatch_phone, :website, :description, :reservation_notification, :blackout_dates,
        :airports, :hours_of_operation, :hours_in_advance_to_accept_rez, :pickup_info, :after_hours_info,
        :excess_luggage_charge, :luggage_insured, :child_rate, :child_car_seats_included, :luggage_limitation_policy,
        :company_reservation_policy, :company_cancellation_policy, :child_safety_policy, :pet_car_seat_policy,
        :vehicle_types, :other_vehicle_types, :notification_fax, :notification_email, :city, :active,
        :active_to_airport, :active_from_airport, :fax, :image, :commission, :payment_type, :airport_pickup_fee,
        :confirmation_emails,
        vehicle_types_attributes: [
          :id, :name, :how_many, :num_of_passengers, :_destroy
        ],
        user_attributes: [
          :email, :password, :password_confirmation, :id
        ]
      )
    end
end
