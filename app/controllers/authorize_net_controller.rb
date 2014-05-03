class AuthorizeNetController < ApplicationController
  before_action :set_user
  
  def submit_transaction
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
end