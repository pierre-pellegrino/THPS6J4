class SessionsController < ApplicationController
  def new
    
  end


  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to gossip_index_path
    else
      flash[:connection_error] = "Email ou mot de passe incorrect"
      render :new
    end
  end


  def destroy
    session.delete(:user_id)
    redirect_to gossip_index_path
  end

end
