require 'rails_helper'
RSpec.describe 'ラベル追加機能', type: :system do
  before do
    label = FactoryBot.create(:test_label)
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session[email]', with: 'user1@gmail.com'    
    fill_in 'session[password]', with: 'user1@gmail.com'    
    click_on 'Log in'
    @current_user = User.find_by(email: "user1@gmail.com")
    visit new_task_path
    sleep(2)
    fill_in 'task[title]', with: '今日の予定'    
    fill_in 'task[content]', with: '配信を見る'
    check "ラベル１"
    click_on '登録する'
  end
  describe '新規作成機能' do
    context 'ラベルを含むタスクを新規作成した場合' do
      it '設定したラベルが詳細画面に存在する' do
        click_on '詳細', match: :first
        expect(page).to have_content 'ラベル１'
      end
    end
  end
  describe 'ラベル検索機能' do
    context '一覧画面でラベルを選択すると' do
      it 'そのラベルで絞り込みができる' do
        visit tasks_path
        select 'ラベル１', from: 'task_label_ids'
        expect(page).to have_content '今日の予定'
      end
    end
  end
end

