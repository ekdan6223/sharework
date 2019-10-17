class FixColumnName < ActiveRecord::Migration[5.0]
    def change
        rename_column :albafavs, :business_id, :bussiness_id
     end
end