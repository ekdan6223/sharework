class AddFavNameToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :fav_name, :string
  end
end
