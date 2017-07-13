namespace :messaging_example do
  desc "Receives email via mail library"
  task receive_mails: :environment do
    expected_local_part_prefix, expected_host = ENV['MAILBOXER_DEFAULT_FROM'].split('@')
    expected_email_pattern_in_text = "#{expected_local_part_prefix}-(.*)@#{expected_host}"
    expected_email_pattern = "^#{expected_email_pattern_in_text}$"
    Mail.all(delete_after_find: false).each do |mail|
      body = mail.text_part.body.to_s.chomp
      body_without_signature = ''
      body.each_line do |line|
        break if "--" == line.strip
        body_without_signature += line
      end
      body_without_signature.chomp!
      body_without_cite_end_empty_lines = ''
      new_message_found = false
      cite_found = false
      body_without_signature.each_line.to_a.reverse.each do |line|
        if new_message_found || (!line.start_with?('>') && !line.blank? && !line.match(expected_email_pattern_in_text))
          body_without_cite_end_empty_lines = line + body_without_cite_end_empty_lines
          new_message_found = true
        else
          cite_found = true
        end
      end
      body_without_cite_end_empty_lines.chomp!
      body_without_cite_end_empty_lines += "\n..." if cite_found
      body_without_reply_email = ''
      body_without_cite_end_empty_lines.each_line { |line| body_without_reply_email += line unless line.match expected_email_pattern_in_text }
      mail.to.uniq.each do |receiver_email|
        match_data = receiver_email.match expected_email_pattern
        next unless match_data
        token = match_data[1]
        receipt = Mailboxer::Receipt.find_by_token token
        next unless receipt
        original_receiver = receipt.receiver
        original_receiver.reply_to_all(receipt, body_without_reply_email)
      end
    end
  end
end
