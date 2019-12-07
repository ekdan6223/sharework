namespace :test do
  task kcm: :environment do
    Favorite.create(user_id: 1, y: 1, x: 1, count: 1, fav_name: "test")
  end
end