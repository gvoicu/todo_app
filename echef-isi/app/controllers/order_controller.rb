class OrderController < ApplicationController

  def index
    if (session[:order_id])
      @order = Order.find(session[:order_id])

      @order_dishes = OrderDish.where("order_id = ?", @order.id)

      # Waiter was called.
      @waiter = Notification.where(:table_id => @order.table_id)

      respond_to do |format|
        format.html # index.html.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to '/menu'}
      end
    end
  end

  # Remove dish from order
  def remove
    order_dish = OrderDish.find(params[:dish_id])
    if order_dish
      order_dish.delete
    end

    respond_to do |format|
      format.js
    end
  end

  # Send order
  def send_order
    order = Order.find(session[:order_id])

    order_dish = OrderDish.where("order_id = ? AND dish_status = ?", order.id, Constant::DS_PENDING)

    order_dish.each do |od|
      od.dish_status = Constant::DS_PREPARING
      od.save
    end

    respond_to do |format|
      format.html { redirect_to '/order'}
    end
  end

  def mark_order_as_checked
    order = Order.find(session[:order_id])
    order.update_attributes(:order_status => Constant::ORDER_CHECKED)

    redirect_to "/orders/#{order.id}"
  end

  def mark_order_as_payed
    order = Order.find(params[:id])
    order.update_attributes(:order_status => Constant::ORDER_PAYED)

    redirect_to "/orders/#{order.id}"
  end

  # Call waiter.
  def call_waiter
    order = Order.find(session[:order_id])
    order.table.notifications.create!(:note => "Come to table", :status => false)

    respond_to do |format|
      format.js
    end
  end

  # Request check.
  def request_check
    order = Order.find(session[:order_id])

    #notif = Notification.new
    #notif.table_id = order.table_id
    #notif.save

    @total    = 0
    @subtotal = 0
    @on_check = 0

    # Mark OrderDishes as checked.
    order_dishes = OrderDish.where("order_id = ?", order.id)
    order_dishes.each do |dish|
      mDish = Dish.find(dish.dish_id)
      @total += mDish.price

      # 5 = check
      if dish.dish_status == Constant::DS_DELIVERED
        dish.dish_status = Constant::DS_CHECK
        dish.save
      end

      if dish.dish_status == Constant::DS_PENDING
        @subtotal += mDish.price
      end

      if dish.dish_status == Constant::DS_CHECK
        @on_check += mDish.price
      end
    end

    respond_to do |format|
      format.js
    end
  end
end
