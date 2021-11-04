class GossipController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  before_action :is_author?, only: [:destroy, :edit]

  def show
    @id = params[:id].to_i
    @gossip = Gossip.find(@id)
  end


  def index

  end


  def new
    @tags = Tag.all
  end


  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user) # avec xxx qui sont les données obtenues à partir du formulaire
    @tag = Tagger.new(gossip:@gossip, tag:Tag.find(params[:tag]))

    if @gossip.save # essaie de sauvegarder en base @gossip
      @tag.save
      flash[:gossip_success] = "Gossip créé avec succès"
      redirect_to '/'
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)    
      errors = []
      @gossip.errors.full_messages.each do |erreur|
        errors << erreur
      end
      flash[:gossip_error] = errors
      render new_gossip_path
    end
  end


  def edit
    @gossip = Gossip.find(params[:id])
  end


  def update
    @gossip = Gossip.find(params[:id])
    post_params = params.require(:gossip).permit(:title, :content)
    if @gossip.update(post_params)
      flash[:edit_gossip_success] = "Gossip modifié avec succès"
      redirect_to gossip_path(params[:id])
    else
      errors = []
      @gossip.errors.full_messages.each do |erreur|
        errors << erreur
      end
      flash[:edit_gossip_error] = errors
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossip_index_path
  end



  private

  def authenticate_user
    unless current_user
      flash[:connection_needed] = "Connectez-vous pour accéder à ce contenu."
      redirect_to new_session_path
    end
  end

  def is_author?
    unless current_user == Gossip.find(params[:id]).user
      redirect_to gossip_index_path
    end
  end
  
end
