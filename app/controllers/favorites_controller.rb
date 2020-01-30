class FavoritesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    favorite = @article.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @article = Article.find(params[:article_id])
    favorite = current_user.favorites.find_by(article_id: @article.id)
    favorite.destroy
  end

  private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_back(fallback_location: root_url)
    when 1
      redirect_back(fallback_location: root_url)
    end
  end
end
