class PagesController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to page_url(current_user)
  end

  def show
    #@posts = Post.where(user_id: current_user.id)
  end
end
