class TagsController < ApplicationController

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
    book = Book.find params[:book_id]
    @tag = book.tags.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.json { render :show, status: :created }
      end
    end
  end

  private

    def tag_params
      params.fetch(:tag, {}).permit!
    end
end
