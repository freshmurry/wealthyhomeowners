class MessagesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_conversation, only: [:show, :destroy]

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "You don't have permission to view this."
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")

    # if current_user == home.user
    #   flash[:alert] = "You cannot send a message to yourself!"
    #   redirect_to home
    # end
      
    if @message.save
      ActionCable.server.broadcast "conversation_#{@conversation.id}", message: render_message(@message)
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_url
    # @message = Message.find(params[:id])
    # @conversation = @message.conversation

    # @message.destroy
    # @messages = Message.where(conversation_id: @conversation.id)

    # respond_to :js

    redirect_back(fallback_location: request.referer, notice: "Message Deleted!")
  end
  
  private

    def render_message(message)
      self.render(partial: 'messages/message', locals: {message: message})
    end

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:context, :user_id)
    end
end