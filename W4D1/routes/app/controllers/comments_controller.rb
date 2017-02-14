class CommentsController < ApplicationController
  def index
    object = nil
    if params[:user_id]
      object = User.find(params[:user_id])
    elsif params[:contact_id]
      object = Contact.find(params[:contact_id])
    elsif params[:contact_shares_id]
      object = ContactShare.find(params[:contact_shares_id])
    end

    render json: object.comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render(
        json: comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    render json: Comment.find(params[:id])
  end

  def update
    @comment = Comment.update(params[:id], comment_params)
    if @comment.update
      render json: @comment
    else
      render(
        json: comment.errors.full_messages, status: :unprocessable_entity
    )
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  private

  def comment_params
    params[:comment].permit(:text, :author_id, :comment_id_id, :comment_id_type)
  end
end
