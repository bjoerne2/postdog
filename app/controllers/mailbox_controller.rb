class MailboxController < ApplicationController

  layout 'messages'

  def inbox
    @conversations = mailbox.inbox
    @active = :inbox
    render :conversations
  end

  def sent
    @conversations = mailbox.sentbox
    @active = :sent
    render :conversations
  end

  def trash
    @conversations = mailbox.trash
    @active = :trash
    @empty_trash_enabled = true
    render :conversations
  end

  def empty_trash
    mailbox.trash.destroy_all
    flash[:notice] = "Success!"
    redirect_to mailbox_trash_path
  end
end
