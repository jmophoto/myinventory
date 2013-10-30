class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      ContactMailer.contact_form(@message).deliver
      render json: @message
    else
      render "new"
    end
  end
end