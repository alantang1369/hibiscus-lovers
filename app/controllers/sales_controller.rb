class SalesController < ApplicationController
    def index
        if params[:user_id]
            @user =  User.find_by(id: params[:user_id])
            @sales = @user.sales
        elsif params[:cultivar_id]
            @cultivar = Cultivar.find(params[:cultivar_id])
            @sales = @cultivar.sales
        else
            @sales = Sale.all 
        end
    end
 
    def new
        @sale = Sale.new(cultivar_id: params[:cultivar_id])
    end 
  
    def create 
        @sale = Sale.new(sale_params)
        if @sale.save
            redirect_to sale_path(@sale)
        else
            render 'new'
        end
    end

    def show 
        @sale = Sale.find(params[:id])
    end

    def edit
        if params[:cultivar_id]
            @cultivar = Cultivar.find_by(id: params[:cultivar_id])
            if @cultivar.nil?
              redirect_to cultivars_path, alert: "Cultivar not found."
            else
              @sale = @cultivar.sales.find_by(id: params[:id])
              redirect_to cultivar_sales_path(cultivar), alert: "Sale not found." if @sale.nil?
            end
        else
            @sale = Sale.find(params[:id])
            redirect_to sale_path(@sale), alert: "Sale not found." if @sale.nil?
            redirect_to sale_path(@sale), alert: "You are not allowed to edit other user's sale." if @sale.user.id != current_user.id
        end
    end

    def update 
        @sale = Sale.find(params[:id])
        @sale.update(sale_params)
        redirect_to sale_path(@sale)
    end

    def destroy
        @sale = Sale.find(params[:id])
        @user = User.find(params[:user_id])
        @sale.destroy if user_is_current_user(@user) || admin?
        redirect_to user_sales_path(@user)
    end


    private

    def sale_params 
        params.require(:sale).permit(
            :user_id,
            :cultivar_id,
            :available_seed,
            :seed_price,
            :cultivar_name

        )
    end
end
