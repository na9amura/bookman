class TagsController < ApplicationController

  def index
    @tags = Tag.all
    respond_to do |format|
      format.json { @tags.to_json }
      format.html { redirect_to controller: :application, action: :index }
    end
  end
end
