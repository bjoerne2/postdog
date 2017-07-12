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
    render :conversations
  end
end
