class CreateAlbafavs < ActiveRecord::Migration[5.2]
  def change
    create_table :albafavs do |t|
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
