class PublicController < ApplicationController
  rescue_from ActionView::MissingTemplate do
    render :index
  end

  def index
  	@posts = Post.limit(4).includes(:photos)
  end

  def travels
  	@posts = Post.includes(:photos).travel.limit(3)
    @pins = Post.travel.pluck(:locX, :locY, :id, :title, :created_at)
    @controller = 'travels'
  end

  def food
  	@posts = Post.includes(:photos).food.limit(4)
    @controller = 'food'
  end

  def life
  	@posts = Post.includes(:photos).life.limit(4)
    @controller = 'life'
  end

  def about
    @controller = 'about'
  	@post = Post.find(1)
  end
  

end
