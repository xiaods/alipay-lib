class OrdersController < ApplicationController
 include OnlinePayResult
 
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all
    
    @pay_types = PayType.all #支付类型
    @prices = {:test => 0.01} #价格

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  # def show
  #   @order = Order.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @order }
  #   end
  # end

  # GET /orders/new
  # GET /orders/new.xml
  # def new
  #   @order = Order.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @order }
  #   end
  # end

  # GET /orders/1/edit
  # def edit
  #   @order = Order.find(params[:id])
  # end

  # POST /orders
  # POST /orders.xml
  def create
    @prices = {:test => 0.01} #价格
    
    order = Order.new(params[:order].update(:total_price => @prices.values.sum) )
    
    order.save!
    session[:order] = nil
    redirect_to :action => :pay, :id => order.order_code
  end
  
  def pay
    @order = Order.find_by_order_code(params[:id])
  end
    


  


  # PUT /orders/1
  # PUT /orders/1.xml
  # def update
  #   @order = Order.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @order.update_attributes(params[:order])
  #       flash[:notice] = 'Order was successfully updated.'
  #       format.html { redirect_to(@order) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  # def destroy
  #   @order = Order.find(params[:id])
  #   @order.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(orders_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
