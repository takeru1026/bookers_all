class CommentsController < ApplicationController
  def create
    @book=Book.find(params[:book_id])
    @comment= current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    if @comment.save
      redirect_back(fallback_location: books_path)
    else
      @book=Book.find(params[:book_id])
      @comment_new = @comment
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: books_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
