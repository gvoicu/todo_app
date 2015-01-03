class OrderDishesController < ApplicationController
  # GET /order_dishes
  # GET /order_dishes.json
  def index
    @order_dishes = OrderDish.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_dishes }
    end
  end

  # GET /order_dishes/1
  # GET /order_dishes/1.json
  def show
    @order_dish = OrderDish.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_dish }
    end
  end

  # GET /order_dishes/new
  # GET /order_dishes/new.json
  def new
    @order_dish = OrderDish.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_dish }
    end
  end

  # GET /order_dishes/1/edit
  def edit
    @order_dish = OrderDish.find(params[:id])
  end

  # POST /order_dishes
  # POST /order_dishes.json
  def create
    @order_dish = OrderDish.new(params[:order_dish])

    respond_to do |format|
      if @order_dish.save
        format.html { redirect_to @order_dish, notice: 'Order dish was successfully created.' }
        format.json { render json: @order_dish, status: :created, location: @order_dish }
      else
        format.html { render action: "new" }
        format.json { render json: @order_dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_dishes/1
  # PUT /order_dishes/1.json
  def update
    @order_dish = OrderDish.find(params[:id])

    respond_to do |format|
      if @order_dish.update_attributes(params[:order_dish])
        format.html { redirect_to @order_dish, notice: 'Order dish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_dishes/1
  # DELETE /order_dishes/1.json
  def destroy
    @order_dish = OrderDish.find(params[:id])
    @order_dish.destroy

    respond_to do |format|
      format.html { redirect_to order_dishes_url }
      format.json { head :no_content }
    end
  end

  def change_status
    order_d = OrderDish.find(params[:id])
    order_d.update_attributes(:dish_status => params[:dish_status])
    render "1".to_json
  end
end
