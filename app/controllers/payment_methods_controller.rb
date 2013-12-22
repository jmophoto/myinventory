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
  
  def update
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.update_attributes(payment_method_params)
    if @payment_method.is_default? && @user.subscription.subscription_id
      sub = BraintreeRails::Subscription.find(@user.subscription.subscription_id)
      sub.update_attributes(payment_method_token: @payment_method.token)
      @user.payment_methods.where('id != ?', @payment_method.id).update_all(is_default: false)
    end
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
     # Use callbacks to share common setup or constraints between actions.
     def set_user
       @user = current_user
     end
     
     # Only allow a trusted parameter "white list" through.
     def payment_method_params
       params.require(:payment_method).permit!
     end
       
  
end
