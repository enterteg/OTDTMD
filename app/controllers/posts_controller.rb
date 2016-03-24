class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		redirect_to @post, notice: 'Post added successfully'
  	else
  		flash.now.notice = 'Some errors occured, cannot create post.'
  		render :new
  	end
  end

  def show
  end
  def edit
  end

  def update
  	if @post.update(post_params)
  		redirect_to @post, notice: 'Post updated successfully'
  	else
  		flash.now.notice = 'Some errors occured, cannot update post.'
  		render :edit
  	end
  end

  def destroy
  	if @post.destroy
  		redirect_to :root, notice: 'Post deleted successfully'
  	else
  		redirect_to @post, notice: 'Cannot delete post, some errors occured'
  	end
  end
  def update_form
    @category_id = params[:category_id]

    respond_to do |format|
      format.js
    end 
  end
private
	def find_post
		@post = Post.find(params[:id])
	end
	def post_params
		params.require(:post).permit(:title,:desc,:category_id, :locX, :locY)
	end
end
