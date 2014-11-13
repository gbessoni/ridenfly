class Admin::RatesController < Admin::ApplicationController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]
  require_role :admin, :company

  # GET /admin/rates
  # GET /admin/rates.json
  def index
    @q = Rate.ransack(params[:q])
    respond_to do |format|
      format.html { @rates = paginate_model @q.result }
      format.csv  { send_csv_file(@q.result) }
    end
  end

  # GET /admin/rates/1
  # GET /admin/rates/1.json
  def show
  end

  # GET /admin/rates/new
  def new
    @rate = Rate.new
  end

  # GET /admin/rates/1/edit
  def edit
  end

  # POST /admin/rates
  # POST /admin/rates.json
  def create
    @rate = Rate.new(rate_params)
    set_rate_company

    respond_to do |format|
      if @rate.save
        format.html {
          html_success_response(@rate, 'Rate was successfully created.')
        }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html {
          html_error_response(@rate, 'new')
        }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/rates/1
  # PATCH/PUT /admin/rates/1.json
  def update
    set_rate_company
    respond_to do |format|
      if @rate.update(rate_params)
        format.html {
          html_success_response(@rate, 'Rate was successfully updated.')
        }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html {
          html_error_response(@rate, 'edit')
        }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/rates/1
  # DELETE /admin/rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to admin_rates_url, notice: 'Rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(
        :airport_id, :company_id, :vehicle_type_passenger, :service_type, :base_rate, :additional_passenger,
        :zipcode, :hotel_landmark_name, :hotel_landmark_street, :hotel_landmark_city,
        :hotel_landmark_state, :trip_duration
      )
    end

    def set_rate_company
      @rate.company = current_user.company if current_user.company? && current_user.company.present?
    end
end
