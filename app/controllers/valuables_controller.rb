class ValuablesController < ApplicationController
  before_action :set_valuable, only: [:show, :edit, :update, :destroy]

  # GET /valuables
  def index
    @valuables = Valuable.all
  end

  # GET /valuables/1
  def show
  end

  # GET /valuables/new
  def new
    @valuable = Valuable.new
  end

  # GET /valuables/1/edit
  def edit
  end

  # POST /valuables
  def create
    @valuable = Valuable.new(valuable_params)

    if @valuable.save
      respond_to do |format|
        format.html { redirect_to @valuable, notice: 'Inspected room was successfully created.' }
        format.json { render :json => @valuable.to_json }
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /valuables/1
  def update
    if @valuable.update(valuable_params)
      redirect_to @valuable, notice: 'Valuable was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /valuables/1
  def destroy
    @valuable.destroy
    redirect_to valuables_url, notice: 'Valuable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valuable
      @valuable = Valuable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def valuable_params
      params.require(:valuable).permit!
    end
end
