class AmazonBooksApiController < ApplicationController
  def index
    @result = AmazonApi.find_books(params[:q])
    respond_to do |format|
      format.any { render json: @result }
    end
  end
end
