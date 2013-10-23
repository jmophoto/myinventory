class InspectionDetailsController < ApplicationController
  before_action :set_inspection_detail, only: [:show, :edit, :update, :destroy]

  # GET /inspection_details
  def index
    @inspection_details = InspectionDetail.all
  end

  # GET /inspection_details/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @inspected_detail.to_json }
    end
  end

  # GET /inspection_details/new
  def new
    @inspection_detail = InspectionDetail.new
  end

  # GET /inspection_details/1/edit
  def edit
  end

  # POST /inspection_details
  def create
    @inspection_detail = InspectionDetail.new(inspection_detail_params)
    
    if @inspection_detail.save
      respond_to do |format|
        format.html { redirect_to @inspection_detail, notice: 'Inspected detail was successfully created.' }
        format.json { render :json => @inspection_detail.to_json }
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /inspection_details/1
  def update
    if @inspection_detail.update(inspection_detail_params)
      respond_to do |format|
        format.html { redirect_to @inspection_detail, notice: 'Inspection detail was successfully updated.' }
      end
    else
      render action: 'edit'
    end
  end  

  # DELETE /inspection_details/1
  def destroy
    @inspection_detail.destroy
    redirect_to inspection_details_url, notice: 'Inspection detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection_detail
      @inspection_detail = InspectionDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def inspection_detail_params
      params[:inspection_detail].permit!
    end
end
