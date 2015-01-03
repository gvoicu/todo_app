class CreateCookAndWaiter < ActiveRecord::Migration
  def up
    User.create!(:username => 'waiter', :name => 'Waiter', :email => '', :password => 'waiter', :u_type => User::WAITER)
    User.create!(:username => 'e-chef', :name => 'Chef', :email => '', :password => 'e-chef', :u_type => User::CHEF)
  end

  def down
    User.delete_all(:username => ["waiter", "chef"])
  end
end
