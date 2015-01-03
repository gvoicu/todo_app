class MenuController < ApplicationController

  def index
     @dishes = Dish.all

     if session[:order_id]
      @order = Order.find_by_id(session[:order_id])
      if @order && @order.is_open?
        @notif = Notification.find_by_table_id(@order.table_id)
      else
        session[:order_id] = nil
        @order = nil
      end
     end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dishes }
    end
  end

  # Get table from QR.
  def table
    qr_table = Table.find_by_qr_code(params[:qr])

    if qr_table
      oldOrder = Order.find_by_table_id(qr_table.id)

      if oldOrder && oldOrder.is_open?
        order = oldOrder
      else
        order = Order.new
        order.table = qr_table
        order.save
      end

      session[:order_id] = order.id
    end

    respond_to do |format|
      format.html { redirect_to '/menu'}
    end
  end

  # Add dish to order.
  def add 
    if session[:order_id]
      dish = Dish.find(params[:dish_id])

      order_dish          = OrderDish.new
      order_dish.order_id = session[:order_id]
      order_dish.dish     = dish

      # 2 for sent order
      order_dish.dish_status = 1;

      order_dish.time = dish.time;

      order_dish.save
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def create_order(qr_table)
    order       = Order.new
    order.table = qr_table
    order.save
    session[:order_id] = order.id
  end
end
