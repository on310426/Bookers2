class BooksController < ApplicationController
  
  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def index
    @newbook = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new

  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "You have destoroyed book successfully."
    redirect_to books_path
    
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
