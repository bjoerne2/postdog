class ConversationsController < ProtectedController

  layout 'messages'

  def new
    @conversation_transient_model = ConversationTransientModel.new
  end

  def create
    @conversation_transient_model = ConversationTransientModel.new(conversation_params)
    if @conversation_transient_model.valid?
      recipients = User.where(id: @conversation_transient_model.recipients)
      conversation = current_user.send_message(recipients, @conversation_transient_model.body, @conversation_transient_model.subject).conversation
      flash[:notice] = "Your message was successfully sent!"
      redirect_to conversation_path(conversation)
    else
      flash[:error] = "Errors found!"
      render action: 'new'
    end
  end

  def show
    @receipts = conversation.receipts_for(current_user).order("created_at ASC")
    conversation.mark_as_read(current_user)
    @message_transient_model = MessageTransientModel.new
  end

  def reply
    @message_transient_model = MessageTransientModel.new(message_params)
    if @message_transient_model.valid?
      current_user.reply_to_conversation(conversation, @message_transient_model.body)
      flash[:notice] = "Your reply message was successfully sent!"
      redirect_to conversation_path(conversation)
    else
      flash[:error] = "Errors found!"
      @receipts = conversation.receipts_for(current_user).order("created_at ASC")
      render action: 'show'
    end
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation_transient_model).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:message_transient_model).permit(:body)
  end
end
