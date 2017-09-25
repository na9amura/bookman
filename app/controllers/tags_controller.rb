class TagsController < ApplicationController
  before_action :set_book, only: %i(create destroy)

  def index
    @tags = Tag.all
    respond_to do |format|
      format.json { @tags.to_json }
      format.html { redirect_to controller: :application, action: :index }
    end
  end

  def show
    respond_to do |format|
      format.json { @tag.to_json }
    end
  end

  def create
    @tag = @book.tags.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.json { render :show, status: :created }
      end
    end
  end

  def destroy
    @tag = @book.tags.find_by(id: params[:id])
    respond_to do |format|
      if @tag.destroy
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { render :show, status: :accepted }
      end
    end
  end

  private

    def set_book
      @book = Book.find params[:book_id]
    end

    def tag_params
      params.fetch(:tag, {}).permit!
    end
end
