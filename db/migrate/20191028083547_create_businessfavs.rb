class CreateBusinessfavs < ActiveRecord::Migration[5.2]
  def change
    create_table :businessfavs do |t|
      t.integer :user_id
      t.integer :bussiness_id

      t.timestamps
    end
  end
end
