class UsersController < ApplicationController
  def show
    @id = params[:id].to_i
  end


  def new

  end


  def create
    @user = User.new(
      first_name: params[:first_name], 
      last_name: params[:last_name],
      description: params[:description],
      email: params[:email],
      age: params[:age],
      city: City.find(params[:city]),
      password: params[:password]
    )
    # /\ Sera modifié plus tard pour intégrer un login
    if @user.save
      flash[:new_user_success] = "Votre compte a bien été créé."
      session[:user_id] = @user.id
      redirect_to gossip_index_path
    else
      errors = []
      @user.errors.full_messages.each do |error|
        errors << error
      end
      flash[:new_user_errors] = errors
      render :new
    end
  end

end
