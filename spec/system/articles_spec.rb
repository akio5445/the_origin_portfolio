require "rails_helper"

describe "記事投稿機能", type: :system do

    let(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com") }
    let(:user_b) { FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com") }
    let!(:article_a) { FactoryBot.create(:article,
                                         title: "最初の記事", description: "最初の本文", user: user_a) }
    let!(:article_b) { FactoryBot.create(:article,
                                         title: "次の記事", description: "次の本文", user: user_b) }

    before do
      visit login_path
      fill_in "Email", with: login_user.email
      fill_in "Password", with: login_user.password
      click_button "ログインする"
    end

    shared_examples_for "ユーザーAが作成した記事が表示される" do
      it { expect(page).to have_content "最初の記事" }
    end

    describe "top#index記事一覧表示機能" do
      context "ユーザーAがログインしている時" do
        let(:login_user) { user_a }

        it_behaves_like "ユーザーAが作成した記事が表示される"
      end
      context "ユーザーBがログインしている時" do
        let(:login_user) { user_b }

        it "ユーザーBが作成した記事が記事一覧ページに表示される" do
          expect(page).to have_content "次の記事"
        end
      end
    end

    describe "articles#index記事一覧表示機能" do
      context "ユーザーAがログインしている時" do
        let(:login_user) { user_a }

        before do
          visit articles_path
        end

        it_behaves_like "ユーザーAが作成した記事が表示される"
      end
    end

    describe "articles#new新規作成機能" do
      let(:login_user) { user_a }

      before do
        visit new_article_path
        fill_in "article_title", with: article_title
        fill_in "article_description", with: article_description
        click_button "登録する"
      end
      context "新規作成画面でタイトル、記事を入力した時" do
        let(:article_title) { "新規作成のテストを書く" }
        let(:article_description) { "新規作成の本文を書く" }

        it "正常に登録される" do
          expect(page).to have_selector ".article_title", text: "新規作成のテストを書く"
          expect(page).to have_selector ".article_body_show", text: "新規作成の本文を書く"
        end
      end

      #context "新規作成画面でタイトルを入力しなかった時" do
      #  let(:article_title) { "" }
      #  let(:article_description) { "新規作成の本文を書く" }
      #
      #  it "エラーとなる" do
      #    within "#error_explanation" do
      #      expect(page).to have_content "タイトルを入力してください"
      #    end
      #    expect(page).to have_selector ".article_body", text: "新規作成の本文を書く"
      #  end
      #end

    end

end
