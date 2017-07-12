class AddTokenToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :mailboxer_receipts, :token, :String
  end
end
