require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザー新規作成した場合' do
      it 'ユーザー画面に遷移する' do
        visit new_user_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user1@gmail.com'
        fill_in 'user[password]', with: 'user1@gmail.com'
        fill_in 'user[password_confirmation]', with: 'user1@gmail.com'
        click_on '登録する'
        expect(page).to have_content 'user1'
      end
    end 

    context 'ログインせずにタスク一覧に飛ぶ場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end 

  end
  
  describe 'セッション機能のテスト' do
    context 'ログインした後' do
      it 'マイページに遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        expect(page).to have_content 'user1'
      end
    end 
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit user_path(2)
        # binding.pry
        expect(page).to have_content 'タスク投稿'
      end
    end 
    context 'ログアウトをすると' do
      it 'ログイン画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'Log in'
      end
    end

  end


  describe '管理画面のテスト' do

    before do
      user = FactoryBot.create(:user)
    end

    context '管理ユーザがログインすると' do  
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者'
      end
    end

    context '管理ユーザがログインすると' do  
      it 'ユーザー詳細画面にアクセスできる' do

        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit admin_users_path
        click_on '投稿', match: :first
        expect(page).to have_content 'の投稿タスク'
      end
    end

    context '管理ユーザがログインすると' do  
      it 'ユーザー新規登録ができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user3'
        fill_in 'user[email]', with: 'user3@gmail.com'
        select '管理者ユーザー', from: 'user_admin'
        fill_in 'user[password]', with: 'user3@gmail.com'
        fill_in 'user[password_confirmation]', with: 'user3@gmail.com'
        click_on '登録する'
        expect(page).to have_content 'user3'
      end
    end

    context '管理ユーザがログインすると' do  
      it '編集画面からユーザを編集できる' do
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit admin_users_path
        click_on '編集', match: :first
        fill_in 'user[name]', with: 'user2_fixed'
        fill_in 'user[email]', with: 'user3@gmail.com'
        fill_in 'user[password]', with: 'user2@gmail.com'
        fill_in 'user[password_confirmation]', with: 'user2@gmail.com'
        click_on '登録する'
        expect(page).to have_content 'user2_fixed'
      end
    end

    context '管理ユーザがログインすると' do  
      it 'ユーザの削除をできる' do
        user = FactoryBot.create(:third_user, name: '太郎', email: "taro@gmail.com", admin: true)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@gmail.com'
        fill_in 'session[password]', with: 'user1@gmail.com'
        click_on 'Log in'
        visit admin_users_path
        click_on '削除', match: :first
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).not_to have_content 'user2_fixed'
      end
    end
  end

  describe '管理画面のテスト(一般ユーザー)' do
    context '一般ユーザは' do
      it '管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'session[email]', with: 'user2@gmail.com'
        fill_in 'session[password]', with: 'user2@gmail.com'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者権限がありません。'
      end
    end     

  end
end
