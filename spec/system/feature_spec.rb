require "rails_helper"

RSpec.describe "記事投稿機能", type: :system do

  let(:user_a) { FactoryBot.create(:user, name: "ユーザーA") }
  let(:user_b) { FactoryBot.create(:user, name: "ユーザーB") }
  let!(:article_a) { FactoryBot.create(:article,
                                       title: "最初の記事", description: "最初の本文", user: user_a) }
  let!(:article_b) { FactoryBot.create(:article,
                                       title: "次の記事", description: "次の本文", user: user_b) }
  before "ログインする" do
    visit login_path
    fill_in "Email", with: login_user.email
    fill_in "Password", with: login_user.password
    click_button "ログインする"
    expect(page).to have_content "ログインしたよ！"
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
      before "記事一覧画面に移行したら" do
        visit articles_path
      end

      it_behaves_like "ユーザーAが作成した記事が表示される"
    end
  end

  describe "articles#new新規作成機能" do
    let(:login_user) { user_a }
    before "新規登録する" do
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

    context "新規作成画面で何も入力しなかった時" do
      let(:article_title) { "" }
      let(:article_description) { "" }
      it "エラーとなる" do
        within "#error_explanation" do
          expect(page).to have_content "Title"
          expect(page).to have_content "Description"
        end
      end
    end
  end

  describe "/ページ表示" do
    context "ユーザーがログインしている時" do
      let(:login_user) { user_a }
      before "/画面に移行したら" do
        visit root_path
      end
      it "ログイン後ヘッダーが表示されている" do
        expect(page).to have_link "THE ORIGIN"
        expect(page).to have_link "ログアウト"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "アカウント"
      end
      it "リンク先が正しいか" do
        click_link "THE ORIGIN"
        expect(page).to have_content("最初の記事")
        end
      it "リンク先が正しいか" do
        visit root_path
        click_link "アカウント"
        expect(page).to_not have_content("ユーザーA")
      end
      it "bodyにSNS共有リンクがが表示されている" do
        expect(page).to have_link "Twitter"
        expect(page).to have_link "Facebook"
        expect(page).to have_link "LINE"
        expect(page).to have_link "Slack"
      end
      it "bodyに投稿記事のリンクがが表示されている" do
        expect(page).to have_link "最初の記事"
        expect(page).to have_content "(; ･`д･´)"
      end
      it "bodyにサイドバーが表示されている" do
        expect(page).to have_css ".button_search"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "年"
      end
    end
  end
  describe "記事一覧ページ表示" do
    context "ユーザーがログインしている時" do
      let(:login_user) { user_a }
      before "記事一覧画面に移行したら" do
        visit articles_path
      end
      it "ログイン後ヘッダーが表示されている" do
        expect(page).to have_link "THE ORIGIN"
        expect(page).to have_link "ログアウト"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "アカウント"
      end
      it "bodyにSNS共有リンクがが表示されている" do
        expect(page).to have_link "Twitter"
        expect(page).to have_link "Facebook"
        expect(page).to have_link "LINE"
        expect(page).to have_link "Slack"
      end
      it "bodyに投稿記事のリンクがが表示されている" do
        expect(page).to have_link "最初の記事"
        expect(page).to have_content "(; ･`д･´)"
      end
      it "bodyにサイドバーが表示されている" do
        expect(page).to have_css ".button_search"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "年"
      end
    end
  end
  describe "記事詳細ページ表示" do
    context "ユーザーがログインしている時" do
      let(:login_user) { user_a }
      before "記事詳細画面に移行したら" do
        visit article_path(article_a)
      end
      it "ログイン後ヘッダーが表示されている" do
        expect(page).to have_link "THE ORIGIN"
        expect(page).to have_link "ログアウト"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "アカウント"
      end
      it "bodyにSNS共有リンクがが表示されている" do
        expect(page).to have_link "Twitter"
        expect(page).to have_link "Facebook"
        expect(page).to have_link "LINE"
        expect(page).to have_link "Slack"
      end
      it "bodyに投稿記事のリンクがが表示されている" do
        expect(page).to have_link "最初の記事"
        expect(page).to have_content "(; ･`д･´)"
      end
      it "bodyにサイドバーが表示されている" do
        expect(page).to have_css ".button_search"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "年"
      end
    end
  end
  describe "アカウントページ表示" do
    context "ユーザーがログインしている時" do
      let(:login_user) { user_a }
      before "ユーザー詳細画面に移行したら" do
        visit user_path(user_a)
      end
      it "ログイン後ヘッダーが表示されている" do
        expect(page).to have_link "THE ORIGIN"
        expect(page).to have_link "ログアウト"
        expect(page).to have_link "記事一覧"
        expect(page).to have_link "アカウント"
      end
      it "bodyに投稿記事のリンクがが表示されている" do
        expect(page).to have_link "最初の記事"
        expect(page).to have_link "年"
      end
      it "記事編集ボタンが表示される" do
        expect(page).to have_link "編集"
        expect(page).to have_link "削除"
        expect(page).to have_link "記事を書く"
      end
    end
  end
end
