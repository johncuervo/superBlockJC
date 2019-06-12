class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.js # renders create.js.erb
      else
        format.js
      end
    end
  end

  def edit
  end

  # def update
  #   if @comment.update (comment_params)
  #     flash[:notice] = "Comentario editado exitosamente."
  #     redirect_to post_path(id: params[:comment][:post_id])
  #   else
  #     render post
  #   end
  # end

  def destroy

    @comment.destroy
    redirect_to post_path( @comment.post_id), notice: 'Comentario eliminado exitosamente'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
