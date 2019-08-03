class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @user = current_user
    @book = Book.new
    @books = Book.find(params[:id])
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(book.id)
    else
        flash[:alert] = "error"
        #redirect_to edit_book_path(book.id)
        @book = Book.find(params[:id])
        render 'books/edit'
    end
  end


  def create
  	book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "successfully"
      redirect_to book_path(book.id) #新しく作られたidのところに行く
    else
    @user = current_user
    @book = book
    @users = User.all
    @books = Book.all
      render 'books/index'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
      params.require(:book).permit(:title, :body)
  end
end
