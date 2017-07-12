class MessageMailer < Mailboxer::MessageMailer

  def mail(headers = {}, &block)
    headers[:template_path] = 'mailboxer/message_mailer'
    receipts = @message.receipts.select { |receipt| receipt.receiver == @receiver && receipt.mailbox_type == 'inbox' }
    raise "Unexpected number of receipts (= #{receipts.count}) for receiver #{@receiver.email}" if receipts.count != 1
    receipt = receipts.first
    headers[:from] = Mailboxer.default_from.sub '@', "-#{receipt.token}@"
    super(headers, &block)
  end
end
