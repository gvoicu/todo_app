class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @order_dishes = @order.order_dishes.includes(:dish).order("order_dishes.time")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.order_status = Constant::ORDER_OPEN

    respond_to do |format|
      if @order.save
        @order.order_dishes.create(:dish_id => params[:order_dish][:dish_id])

        format.html { redirect_to "/orders/#{@order.id}", notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def mark_as_payed
    order = Order.find(params[:id])
    order.pay()

    respond_to do |format|
      format.html { redirect_to "/orders/#{order.id}" }
      format.js
    end
  end

  def mark_as_closed
    order = Order.find(params[:order_id])
    order.close()

    respond_to do |format|
      format.html { redirect_to "/orders/#{order.id}" }
      format.js
    end
  end

  def change_order_time
    order_dish = OrderDish.find(params[:id])
    order_dish.update_attributes(:time => params[:time])

    respond_to do |format|
      format.html { redirect_to "/orders/#{order_dish.order_id}" }
      format.js
    end
  end
end
