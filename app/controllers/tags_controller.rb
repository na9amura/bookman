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
    @tag_assign = @book.try_assign_tag(tag_params[:name])
    respond_to do |format|
      if @tag_assign.persisted?
        format.json do
          render(
            status: Rack::Utils.status_code(:conflict),
            json: { message: "tag:'#{ tag_params[:name] }' already assigned" }.to_json
          )
        end
      elsif @tag_assign.save!
        format.json { render :show, status: :created }
      end
    end
  end

  def destroy
    @tag_assign = @book.delete_tag(params[:id])
    respond_to do |format|
      format.json { render :show, status: :accepted }
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
