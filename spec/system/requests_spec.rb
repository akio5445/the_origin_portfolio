require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { "THE ORIGIN" }
  let(:user) { FactoryBot.create :user }
  let!(:article) { FactoryBot.create :article }

  describe "GET top#index" do                          # root
    it "リクエストが成功すること" do
      get "/"
      expect(response.status).to eq 200
      expect(response.body).to match("THE ORIGIN")
    end
  end
  describe "GET sessions#new" do                       # login
    it "リクエストが成功すること" do
      get "/login"
      expect(response.status).to eq 200
      expect(response.body).to match("THE ORIGIN")
    end
  end
  describe "GET　articles#index" do                     # index
    it "リクエストが成功すること" do
      get articles_url
      expect(response.status).to eq 200
      expect(response.body).to match("THE ORIGIN")
    end
  end
  describe "GET　articles#show" do                      # show
    it 'リクエストが成功すること' do
      get article_url article.id
      expect(response.status).to eq 200
      expect(response.body).to match("THE ORIGIN")
    end
  end

  describe "ログイン済みでないユーザーはリクエストに失敗する" do
    describe "GET　articles#new" do                    # new.Fail
      it 'リクエストが失敗すること' do
        get new_article_url
        expect(response.status).to eq 302
      end
    end
    describe 'GET article#edit' do                    # edit.Fail
      it 'リクエストが失敗すること' do
        get edit_article_url article
        expect(response.status).to eq 302
      end
    end
  end

  describe "ログイン済みのユーザーはリクエストに成功する" do
    before 'ユーザーIDをセッションから取り出せるようにする' do
      allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user.id)
    end

    describe "GET　articles#new" do                    # new
      it 'リクエストが成功すること' do
        get new_article_url
        expect(response.status).to eq 200
        expect(response.body).to match("THE ORIGIN")
      end
    end

    describe "GET　users#show" do                      # show
      it 'リクエストが成功すること' do
        get user_url user.id
        expect(response.status).to eq 200
        expect(response.body).to match("THE ORIGIN")
      end
    end

    describe 'POST article#create' do                # create
      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post articles_url, params: { article: FactoryBot.attributes_for(:article) }
          expect(response.status).to eq 302
        end
        it '記事が登録されること' do
          expect do
            post articles_url, params: { article: FactoryBot.attributes_for(:article) }
          end.to change(Article, :count).by(1)
        end
        it 'リダイレクトすること' do
          post articles_url, params: { article: FactoryBot.attributes_for(:article) }
          expect(response).to redirect_to Article.last
        end
      end
      context 'パラメータが不正な場合' do
        it 'リクエストが失敗すること' do
          post articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          expect(response.status).to eq 200
        end
        it '記事が登録されないこと' do
          expect do
            post articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          end.to_not change(Article, :count)
        end
        it 'エラーが表示されること' do
          post articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          expect(response.body).to include '登録に失敗しました！'
        end
      end
    end

    describe 'PUT articles#update' do               # update
      let(:article_A) { FactoryBot.create :article_A }

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          put article_url article_A, params: { article: FactoryBot.attributes_for(:article_B) }
          expect(response.status).to eq 302
        end
        it '記事タイトルが更新されること' do
          expect do
            put article_url article_A, params: { article: FactoryBot.attributes_for(:article_B) }
          end.to change { Article.find(article_A.id).title }.from('テストを書くA').to('テストを書くB')
        end
        it 'リダイレクトすること' do
          put article_url article_A, params: { article: FactoryBot.attributes_for(:article_B) }
          expect(response).to redirect_to Article.last
        end
      end
      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          put article_url article_A, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          expect(response.status).to eq 200
        end
        it '記事タイトルが変更されないこと' do
          expect do
            put article_url article_A, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          end.to_not change(Article.find(article_A.id), :title)
        end
        it 'エラーが表示されること' do
          put article_url article_A, params: { article: FactoryBot.attributes_for(:article, :invalid) }
          expect(response.body).to include '登録に失敗しました！'
        end
      end
    end

    describe 'DELETE #destroy' do                 # destroy
      let!(:article) { FactoryBot.create :article }
      it 'リクエストが成功すること' do
        delete article_url article
        expect(response.status).to eq 302
      end
      it '記事が削除されること' do
        expect do
          delete article_url article
        end.to change(Article, :count).by(-1)
      end
      it 'アカウントにリダイレクトすること' do
        delete article_url article
        expect(response).to redirect_to(user_url user)
      end
    end
  end
end