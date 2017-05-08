class AddStripeIdToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :stripe_id, :string

    User.find_each do |user|
      customer = Stripe::Customer.create(
        email: user.email,
        metadata: {
          name: user.name
        }
      )
      user.stripe_id = customer.id
      user.save
    end
  end

  def down
    remove_column :users, :stripe_id
  end
end
