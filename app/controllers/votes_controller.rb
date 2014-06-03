class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_votable, only: [:like, :unlike, :destroy]
  before_action :set_vote, only: :destroy
  before_action only: :dislike do
    check_permissions(@vote)
  end

  respond_to :js

  def like
    if @votable.like(current_user)
      render 'votes/like'
    else
      render nothing: true
    end
  end

  def unlike
    if @votable.unlike(current_user)
      render 'votes/vote'
    else
      render nothing: true
    end
  end

  def destroy
    @vote.destroy
    render 'votes/dislike'
  end

  private

  def set_vote
    @vote ||= Vote.find_by(votable_id: @votable.id, votable_type: @votable.class.name, user_id: current_user)
  end

  def set_votable
    parent = %w(answer question).find {|p| params.has_key?("#{p}_id")}
    @votable ||= parent.classify.constantize.find(params["#{parent}_id"])
  end

end
