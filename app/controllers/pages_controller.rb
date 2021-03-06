class PagesController < ApplicationController
  before_action :authenticate_user!,except: [:index,:agreement,:about]
  def index
    if user_signed_in?
      redirect_to page_url(current_user)
    end
  end

  def show
    @posts = Post.where(user_id: current_user.id)
  end

  def agreement
  end

  def about
  end
end
