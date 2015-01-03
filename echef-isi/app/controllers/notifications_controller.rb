class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  def mark_as_done
    noti = Notification.find(params[:id])
    
    @id = noti.id
    
    noti.delete

    respond_to do |format|
      format.html { redirect_to "/notifications" }
    end
  end
  
  def count
    @notifications = 0
    
    if current_user and current_user.waiter?
      @notifications = @notifications + Notification.all.count
    end
    
    if current_user and current_user.chef?
      
      orderDishes = OrderDish.select(:order_id).where("dish_status = ?", Constant::DS_PREPARING).uniq
      
      for orderDish in orderDishes do
        @notifications = @notifications + 1
      end
      
    elsif current_user and current_user.waiter?
      orderDishes = OrderDish.where("dish_status = ?", Constant::DS_READY).select(:order_id).uniq
      for orderDish in orderDishes do
        @notifications = @notifications + 1
      end
      
      orderDishes = OrderDish.where("dish_status = ?", Constant::DS_CHECK).select(:order_id).uniq
      for orderDish in orderDishes do
        @notifications = @notifications + 1
      end
    end
    
    render :layout => false
  end
  
  def refresh
    @notifications = Array.new
    
    if user_signed_in? and current_user.waiter?
      @notifications = Notification.all
    end
    
    @orderNotifications = Array.new
    
    # Daca e chelner
    if user_signed_in? and current_user.chef?
      orderDishes = OrderDish.where("dish_status = ?", Constant::DS_PREPARING).select(:order_id).uniq
      for orderDish in orderDishes do
        @orderNotifications.push({:note => "New food.", :table_id => orderDish.order.table.number, :order => orderDish.order_id})
      end
      
    elsif user_signed_in? and current_user.waiter?
      orderDishes = OrderDish.where("dish_status = ?", Constant::DS_READY).select(:order_id).uniq
      for orderDish in orderDishes do
        @orderNotifications.push({:note => "Food ready.", :table_id => orderDish.order.table.number, :order => orderDish.order_id})
      end
      
      orderDishes = OrderDish.where("dish_status = ?", Constant::DS_CHECK).select(:order_id).uniq
      for orderDish in orderDishes do
        @orderNotifications.push({:note => "Bring check.", :table_id => orderDish.order.table.number, :order => orderDish.order_id})
      end
    end
    
    render :layout => false
  end
end
