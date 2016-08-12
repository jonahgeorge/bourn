class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, not_null: true
      t.string :email, not_null: true
      t.string :password_digest, not_null: true

      t.timestamps
    end
  end
end
