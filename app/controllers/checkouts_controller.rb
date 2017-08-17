class CheckoutsController < ApplicationController
  before_action :set_check, only: :show

  def show
    respond_to do |format|
      format.json @check.to_json
    end
  end

  def create
    @check = Check.out_new(book_params[:id], 1)
    respond_to do |format|
      if @check.persisted?
        format.json { render :show, status: :created }
      else
        format.json do
          render(
            status: Rack::Utils.status_code(:forbidden),
            json: { message: @check.errors.messages }.to_json
          )
        end
      end
    end

  end

  private

    def set_check
      @check = Check.find(params[:id])
    end

    def book_params
      params.fetch(:book, {}).permit(:id)
    end
end
