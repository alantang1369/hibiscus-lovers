class OrdersController < ApplicationController
    
    def index
        

    end

    def create
        @sale = Sale.find(params[:sale_id])
        @order = Order.new(sale_id: params[:sale_id], seed_amount: params[:order][:seed_amount])
        if !@order.seed_amount.blank? && @order.seed_amount <= @sale.available_seed
            @order.total = @order.seed_amount * @sale.seed_price
            @order.save
            redirect_to sale_order_path(@order)
        else
            redirect_to sale_path(@sale), alert: "Please enter a valid number!"
        end
    end

    def show
        @order = Order.find(params[:id])
    end

    def confirm 
        @order = Order.find(params[:id])
        @order.place_order
        redirect_to root_path
    end
    
end