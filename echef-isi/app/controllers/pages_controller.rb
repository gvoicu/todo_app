class PagesController < ApplicationController
  
  def home
      redirect_to :controller => "users", :action => "profile" if user_signed_in?
    
  end
  
  def contact
    
  end
  
  def gallery
    
  end
end
