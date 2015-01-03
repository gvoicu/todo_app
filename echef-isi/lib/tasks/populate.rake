namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [OrderDish, Order, Table, Notification, Booking, Complaint, Dish, DishType].each(&:delete_all)

    DishType.populate 5 do |dt|
      dt.name = Populator.words(2).capitalize
      Dish.populate 15 do |d|
        d.dish_type_id = dt.id
        d.name = Populator.words(1..3).capitalize
        d.ingredients = Faker::Lorem.sentence(10)
        d.grams = 50 .. 500
        d.price = 5 .. 50
        d.time = 5 .. 30
      end
    end

    i = 0
    Table.populate 5 do |t|
      i = i + 1
      t.number = i
      t.qr_code = '111%s' % i 
    end

  end
end
