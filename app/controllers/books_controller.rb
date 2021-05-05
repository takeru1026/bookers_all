class BooksController < ApplicationController
  def index
    @books= Book.all
    @book= Book.new
    @user= current_user
  end

  def create
    @book= Book.new(book_params)
    @user= current_user
    if @book.save
      flash[:success]="successfully"
      redirect_to book_path(@book)
    else
      @books=Book.all
      @user= current_user
      render 'index'
    end
  end

  def show
    @book=Book.find(params[:id])
    @comment_new = Comment.new
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:success]="successfully"
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    book=Book.find(params[:id])
    if book.user.id == current_user.id
      if book.destroy
        flash[:success]="successfully"
        redirect_to books_path
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body).merge(user_id:current_user.id)
  end
end
