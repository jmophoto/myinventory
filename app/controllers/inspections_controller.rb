class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]
  # before_action :admin_user?, only: [:index]
  # before_action :agent_user?, only: [:assigned_index]
  wrap_parameters include: [:name, :details, :desscription, :room_count, :other_areas, :address_attributes, :agent_id, :status, :inspection_date, :inspection_type]

  # GET /inspections
  # GET /inspections.json
  def index
    if current_user.admin?
      @inspections = Inspection.all
    else
      @inspections = current_user.inspections
    end
    respond_to do |format|
      format.html
      format.json { render json: @inspections, root: false }
    end
  end
  
  def admin_index
    @inspections = Inspection.all
    respond_to do |format|
      format.html
      format.json { render json: @inspections, root: false }
    end
  end
  
  def agent_index
    @inspections = current_user.assigned_inspections
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @inspections, root: false }
    end
  end
  
  def assigned_index
    @inspections = Inspection.all
    respond_to do |format|
      format.html
      format.json { render json: @inspections, root: false }
    end
  end
  
  def agents
    @inspections = Inspection.agent
    respond_to do |format|
      format.html
      format.json { render json: @inspections, root: false }
    end
  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @inspection, root: false }
      format.pdf do
        pdf = InspectionPdf.new(@inspection, view_context)
        send_data pdf.render, filename: "inspection_#{@inspection.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
    @inspection.images.build
    @inspection.build_address
    if params[:property_id]
      @inspection.create_from_template(params[:property_id])
    end
  end

  # GET /inspections/1/edit
  def edit
    @inspection.images.build unless @inspection.images.any?
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
  # PATCH/PUT /properties/1
  def update
    unless inspection_params[:inspection_date].blank?
      inspection_params[:inspection_date] = Date.strptime(inspection_params[:inspection_date], '%m/%d/%Y')
    end
    if @inspection.update(inspection_params)
      render json: @inspection, root: false
    else
      render action: 'edit'
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

  def email
    @inspection = Inspection.find(params[:inspection_id])
    pdf = InspectionPdf.new(@inspection, view_context)
    InspectionMailer.email_pdf(@inspection.user, params[:email], pdf).deliver
    redirect_to inspection_path(@inspection)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_params
      params.require(:inspection).permit!
    end
end
