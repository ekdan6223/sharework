class AddDayPaymentToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :day_payment, :string
  end
end
