class LikesController < ApplicationController
  before_action :authenticate_user, only: [:destroy, :new]
  # before_action :is_author?, only: [:destroy, :new]

  def new
    @gossip_id = params[:gossip_id]
    Like.create(likeable: Gossip.find(@gossip_id), user: current_user)
    redirect_to gossip_path(@gossip_id)
  end


  def destroy
    @gossip_id = params[:gossip_id]
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to gossip_path(@gossip_id)
  end

end


private

def authenticate_user
  unless current_user
    flash[:connection_needed] = "Connectez-vous pour accéder à ce contenu."
    redirect_to new_session_path
  end
end

# def is_author?
#   unless current_user == Like.find(likeable: Gossip.find(params[:gossip_id]), user: current_user).user
#     redirect_to gossip_path(@gossip_id)
#   end
# end