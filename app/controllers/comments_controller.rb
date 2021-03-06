class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    if user_signed_in?
      @product = Product.find_by_id(params[:product_id])
      if !@product.blank?
        @comment = @product.comments.new(comment_params)
        @comment.user = current_user
        @comment.save
      else
        redirect_to products_url, alert: "Page not found!"
      end
    end
  end

  def destroy
    @comment.destroy
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end

  private

  def find_comment
    if user_signed_in?
      @comment = current_user.comments.find_by_id(params[:id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :product_id)
  end
end
