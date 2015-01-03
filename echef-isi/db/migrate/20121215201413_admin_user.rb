class AdminUser < ActiveRecord::Migration
  def up
    User.create!(:username => 'administrator', :name => 'Administrator', :email => '', :password => 'administrator', :u_type => '1')
  end

  def down
    user = User.find_by_username('administrator')
    user.delete if user
  end
end
