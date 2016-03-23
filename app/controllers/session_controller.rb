class SessionController < ApplicationController
	def new
		redirect_to :root if current_user
	end

	def create
		reset_session
		user = User.find_by(login: params[:login])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to :root
		else
			flash.now.notice = 'Invalid login or password'
			render :new
		end
	end

	def destroy
		reset_session
		redirect_to :root
	end
end
