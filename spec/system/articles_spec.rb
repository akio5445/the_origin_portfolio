require "rails_helper"

describe "記事投稿機能", type: :system do
  describe "記事一覧表示機能" do
    let(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com") }
    let(:user_b) { FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com") }

    before do
      # ユーザーAを作成
      # 作成者かユーザーAである記事を作成しておく
      FactoryBot.create(:article, title: "最初の記事", user: user_a)
      # ユーザーAでログインする
      # login_pathへのアクセス
      visit login_path
      # メールアドレスラベルのテキストフィールドに入力
      fill_in "Email", with: login_user.email
      # パスワードラベルのテキストフィールドに入力
      fill_in "Password", with: login_user.password
      # ボタンを押す
      click_button "ログインする"
    end

    context "ユーザーAがログインしている時" do
      let(:login_user) { user_a }

      it "ユーザーAが作成した記事が表示される" do
      # 作成済みの記事が画面上に表示されている事を確認
      expect(page).to have_content "最初の記事"
      end
    end

  end
end
