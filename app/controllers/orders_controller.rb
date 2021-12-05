class OrdersController < ApplicationController
    before_action :user_orders_check, only:[:index]
    before_action :order_status_check, only:[:confirm]
    skip_before_action :verify_authenticity_token
    def index
        @user = User.find(params[:user_id])
        @orders = Order.user_orders(@user).order(created_at: :desc)
        
    end 

    def create
        @sale = Sale.find(params[:order][:sale_id])
        
        if !params[:order][:seed_amount].blank? && params[:order][:seed_amount].to_i <= @sale.available_seed && params[:order][:seed_amount].to_i > 0
            @order = Order.new(order_params)
            @order.total = @order.seed_amount * @sale.seed_price
            @order.save
            
            redirect_to confirm_order_path(@sale.id, @order.id)
        else
            redirect_to sale_path(@sale), alert: "Please enter a valid seed number!"
        end
    end 
    
    def confirm 
        @order = Order.find(params[:id])
        
        @sale = Sale.find(params[:sale_id])        
    end


    def update
        @order = Order.find(params[:id])
        if !params[:order][:seed_amount].blank? && params[:order][:seed_amount].to_i <= @order.sale.available_seed && params[:order][:seed_amount].to_i > 0
            @order.update(order_params)#can this take another arg???
            @order.total = @order.seed_amount * @order.sale.seed_price
            @order.save
            redirect_to confirm_order_path(@order.sale.id, @order.id)#"/sales/#{@sale.id}/orders/#{@order.id}/confirm"
        else
            redirect_to confirm_order_path(@order.sale.id, @order.id), alert: "Please enter a valid seed number!"
        end

    end

    def place
        #@sale = Sale.find(params[:sale_id])
        @order = Order.find(params[:order][:id])
        @order.place_order
        redirect_to user_order_path(@order.user, @order), alert: "Sucessfully place your order!"
        
    end

    
    
    def show
        @order = Order.find(params[:id])
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy if !@order.confirm 
            
        redirect_to user_orders_path(current_user)
    end
    
    private
    def order_params
        params.require(:order).permit(
            :sale_id,
            :seed_amount,
            :user_id
        )
    end

    def user_orders_check
        @user = User.find(params[:user_id])
        redirect_to user_path(@user),alert: "You are not allowed to access other user's order!" if @user.id != current_user.id && current_user.admin == false
    end
    
    def order_status_check
        @order = Order.find(params[:id])
        redirect_to sale_order_path(@order.sale, @order), alert: "Access denied! Your order was completed!" if @order.confirm == true
    end
end