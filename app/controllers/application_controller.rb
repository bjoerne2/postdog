class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  helper_method :mailbox, :conversation, :unread_messages_count

  private

  def unread_messages_count
    mailbox.inbox(:unread => true).count(:id)
  end
 
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end
end
