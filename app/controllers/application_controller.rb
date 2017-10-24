class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Knock::Authenticable

  def index
  end

  def login
    @user = User.new
  end
end
