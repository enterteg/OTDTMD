class PublicController < ApplicationController
  
  rescue_from ActionView::MissingTemplate do
    render :index
  end

  def index
  	@posts = Post.where.not(id: 1).paginate_it(params[:page])
  end

  def travels
  	@posts = Post.travel.paginate_it(params[:page])
    @pins = Post.travel.pluck(:locX, :locY, :id, :title, :created_at)
    @controller = 'travels'
  end

  def food
  	@posts = Post.food.paginate_it(params[:page])
    @controller = 'food'
  end

  def life
  	@posts = Post.life.paginate_it(params[:page])
    @controller = 'life'
  end

  def about
  	@post = Post.includes(:photo_files).find_by(id: 1)
    render :nothing unless @post
  end
  
  def search
    @controller = 'search'
    if params[:search].present? 
      @posts = Post.paginate_it(params[:page]).search(params[:search]) 
      p
    else
      redirect_to action: :index
    end
  end

  def search_suggestions
    render json: Post.search(params[:term]).limit(3).pluck(:title)
  end
end
