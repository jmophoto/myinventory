class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  # GET /inspections
  # GET /inspections.json
  def index
    @inspections = current_user.inspections
    respond_to do |format|
      format.html
      format.json { render :json => @inspections.to_json(:include => :inspected_rooms) }
    end
  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @inspection.to_json(:include => :inspected_rooms) }
      format.pdf do
        pdf = InspectionPdf.new(@inspection)
        send_data pdf.render, filename: "inspection_#{@inspection.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
    if params[:property_id]
      @inspection.create_from_template(params[:property_id])
    end
  end

  # GET /inspections/1/edit
  def edit
  end

  # POST /inspections
  # POST /inspections.json
  def create
    @inspection = current_user.inspections.build(inspection_params)

    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inspection }
      else
        format.html { render action: 'new' }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspections/1
  # PATCH/PUT /inspections/1.json
  def update
    respond_to do |format|
      if params[:inspection][:date_string]
        @inspection.inspection_date = Date.strptime(params[:inspection][:date_string], "%m/%d/%Y")
      end
      if @inspection.update(inspection_params)
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1
  # DELETE /inspections/1.json
  def destroy
    @inspection.destroy
    respond_to do |format|
      format.html { redirect_to inspections_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_params
      params.require(:inspection).permit(:inspection_type, :unit, :tenant, :inspected_by, :inspection_date, :address, :city, :state, :zip, :property_id, :date_string)
    end
end
