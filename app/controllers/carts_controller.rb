class CartsController < ApplicationController

    def show
        @cart = Cart.find_by(:id => params[:id])
    end

    def index

    end 

    def checkout
        cart = Cart.find params[:id]
        cart.checkout
        
        redirect_to cart_path(cart)
      end

end
