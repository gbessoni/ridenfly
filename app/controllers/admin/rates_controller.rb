class Admin::RatesController < Admin::ApplicationController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]

  # GET /admin/rates
  # GET /admin/rates.json
  def index
    respond_to do |format|
      format.html { @rates = paginate_model Rate }
      format.csv  { send_csv_file(Rate) }
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

    respond_to do |format|
      if @rate.save
        format.html { redirect_to [:admin, @rate], notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/rates/1
  # PATCH/PUT /admin/rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to [:admin, @rate], notice: 'Rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
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
end
