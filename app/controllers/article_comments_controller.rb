class ArticleCommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    # 慣習的に関連するモデルを生成するときは、buildを使うnewとの違いはない
    @article_comment = @article.article_comments.build(article_comment_params)
    @article_comment.user_id = current_user.id
    if @article_comment.save
      render :index
    end
  end

  def destroy
    @article_comment = ArticleComment.find(params[:id])
    if @article_comment.destroy
      render :index
    end
  end

  private
  def article_comment_params
    params.require(:article_comment).permit(:content, :article_id, :user_id)
  end
end
