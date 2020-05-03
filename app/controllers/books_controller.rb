class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit]

	def create
		@books = Book.all
		@user = User.find_by(id: current_user.id)

		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		   flash[:success] = "You have creatad book successfully."
		   redirect_to book_path(@book)
		else
		   render 'index'
		end
	end

	def index
		@books = Book.all
		@user = User.find_by(id: current_user.id)
		@book = Book.new
	end

	def show
		@deta = Book.find(params[:id])
		@user = @deta.user
		@book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:success] = "You have updated book successfully."
			redirect_to book_path(@book)
	    else
	    	render 'edit'
	    end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.delete
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end

	def correct_user
		book = Book.find(params[:id])
		user = book.user
		if current_user != user
			redirect_to books_path
		end
	end
end
