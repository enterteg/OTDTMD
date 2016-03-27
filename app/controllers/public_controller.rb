class PublicController < ApplicationController
  


  rescue_from ActionView::MissingTemplate do
    render :index
  end

  def index
  	@posts = Post.where.not(id: 1).paginate(page: params[:page], per_page: 4)
  end

  def travels
  	@posts = Post.travel.paginate(page: params[:page], per_page: 3)
    @pins = Post.travel.pluck(:locX, :locY, :id, :title, :created_at)
    @controller = 'travels'
  end

  def food
  	@posts = Post.food.paginate(page: params[:page], per_page: 4)
    @controller = 'food'
  end

  def life
  	@posts = Post.life.paginate(page: params[:page], per_page: 4)
    @controller = 'life'
  end

  def about
  	@post = Post.find(1)
  end
  
  def search
    if params[:search].present? 
      @posts = Post.search(params[:search])
      @controller = 'search'
    else
      redirect_to action: :index
    end
  end
end
