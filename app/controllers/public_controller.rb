class PublicController < ApplicationController
  rescue_from ActionView::MissingTemplate do
    render :index
  end

  def index
  	@posts = Post.all.limit(6)
  end

  def travels
  	@posts = Post.travel.limit(3)
    @pins = Post.travel.pluck(:locX, :locY, :id, :title, :created_at)
    @controller = 'travels'
  end

  def food
  	@posts = Post.food.limit(6)
    @controller = 'food'
  end

  def life
  	@posts = Post.life.limit(6)
    @controller = 'life'
  end

  def about
    @controller = 'about'
  	@post = Post.find(1)
  end
  

end
