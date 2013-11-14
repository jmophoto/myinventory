class PaymentMethodsController < ApplicationController
  before_action :set_user
  
  def index
    @payment_methods = @user.payment_methods
  end
  
  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
     # Use callbacks to share common setup or constraints between actions.
     def set_user
       @user = current_user
     end
  
end
