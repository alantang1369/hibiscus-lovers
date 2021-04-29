module OrdersHelper
    def order_status(order)
        if @order.confirm
         "Completed"
        else
         "Incompleted"
         link_to "(Continue on your order)", confirm_order_path(@order.sale, @order)
        end 
    end
end
