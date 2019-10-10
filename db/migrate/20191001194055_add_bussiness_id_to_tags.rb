class AddBussinessIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :bussiness_id, :string
  end
end
