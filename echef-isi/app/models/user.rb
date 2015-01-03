class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :u_type, :name, :username, :phone
  validates :username, :uniqueness => true
  # attr_accessible :title, :body

  ADMIN = 1
  WAITER = 2
  CHEF = 3

  def admin?
    return self.u_type == User::ADMIN
  end

  def waiter?
    return self.u_type == User::WAITER
  end

  def chef?
    return self.u_type == User::CHEF
  end

  def client?
    return (self.u_type == User::CLIENT || self.u_type.nil?)
  end

  def email_required?
    false
  end
end
