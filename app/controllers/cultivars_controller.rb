class CultivarsController < ApplicationController
    
    def index 
        @cultivars = Cultivar.all
    end 

    def show
        @cultivar = Cultivar.find_by(id: params[:id])
    end

    def edit 
        @cultivar = Cultivar.find_by(id: params[:id])
    end

    def update
        @cultivar = Cultivar.find_by(id: params[:id])
        @cultivar.update(description: params[:cultivar][:description])
        redirect_to @cultivar
    end 
     
    def destroy 
    end

end
