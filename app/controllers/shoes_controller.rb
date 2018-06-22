class ShoesController < ApplicationController
    def index
        @products = Product.all.where.not(user: current_user)
    end

    def create
        product = Product.create(product_params)

        if product.valid?
            product.user_id = current_user.id
            product.save
            redirect_to :back
        else
            flash[:errors] = product.errors.full_messages
            redirect_to :back
        end
    end

    def destroy
        trash = Product.find(params[:id])
        trash.destroy
        redirect_to :back
    end

    private
    def product_params
        params.require(:product).permit(:name, :amount)
    end
end
