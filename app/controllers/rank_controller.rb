class RankController < ApplicationController
  def index
    @result = User.joins(:comments)
                .where("comments.created_at > ?", 7.days.ago)
                .group("users.id").select("users.*, count(comments.id) as comments_count")
                .order("comments_count DESC").limit(10)
  end
end
