class CheckinsController < ApplicationController
  before_action :set_user
  before_action :set_check

  def show
    respond_to do |format|
      format.json @check.to_json
    end
  end

  def create
    respond_to do |format|
      if @check.in!
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

    def set_user
      # @user = current_user
      @user = User.first
    end

    def set_check
      @check = Check.find(params[:id])
    end
end
