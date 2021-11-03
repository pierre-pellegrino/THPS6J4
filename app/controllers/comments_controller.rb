class CommentsController < ApplicationController
  def show
  end


  def new
    @gossip_id = params[:gossip_id]
  end


  def create
    @gossip_id = params[:gossip_id]
    @comment = Comment.new(content: params[:content], commentable: Gossip.find(@gossip_id), user:Gossip.find(@gossip_id).user) 
    # /\ Sera modifié plus tard pour intégrer un login
    if @comment.save
      flash[:new_comment_success] = "Commentaire ajouté."
      redirect_to gossip_path(@gossip_id)
    else
      errors = []
      @comment.errors.full_messages.each do |error|
        errors << error
      end
      flash[:new_comment_errors] = errors
      redirect_to new_gossip_comment_path(@gossip_id)
    end
  end


  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end


  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])

    post_params = params.require(:comment).permit(:content)
    if @comment.update(post_params)
      flash[:edit_comment_success] = "Commentaire modifié avec succès"
      redirect_to gossip_path(params[:gossip_id])
    else
      errors = []
      @comment.errors.full_messages.each do |erreur|
        errors << erreur
      end
      flash[:edit_comment_error] = errors
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(params[:gossip_id])
  end

end
