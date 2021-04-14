class CultivarsController < ApplicationController
    
    def index 
        @cultivars = Cultivar.all
    end 

    def show
        @cultivar = Cultivar.find_by(id: params[:id])
    end

    def edit 
    end

    def update
    end 
     
    def destroy 
    end

end
