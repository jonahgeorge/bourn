class AddConfirmationTokenAndBooleanToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_confirmation_token, :string
    add_column :users, :is_email_confirmed, :bool, default: false
  end
end
