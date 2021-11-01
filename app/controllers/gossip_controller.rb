class GossipController < ApplicationController
  def show
    @id = params[:id].to_i
  end
end
