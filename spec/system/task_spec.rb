require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:second_user)
    visit new_session_path
    fill_in 'session[email]', with: 'user2@gmail.com'    
    fill_in 'session[password]', with: 'user2@gmail.com'    
    click_on 'Log in'
    @current_user = User.find_by(email: "user2@gmail.com")
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[content]', with: 'task'    
        click_on '登録する'
        expect(page).to have_content 'task'
      end
    end
  end
  # let!(:task) { FactoryBot.create(:task, title: 'タイトル1') }
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'タイトル1', content: 'タスク1', user_id: @current_user.id)
        visit tasks_path
        expect(page).to have_content 'タイトル1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'タイトル1', due: "2023-02-10 11:48:00", user_id: @current_user.id)
        task = FactoryBot.create(:second_task, title: 'タイトル2', due: "2023-02-07 11:48:00", user_id: @current_user.id)

        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル2'
        expect(task_list[1]).to have_content 'タイトル1'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        task = FactoryBot.create(:task, title: 'タイトル1', due: "2023-02-10 11:48:00", user_id: @current_user.id)
        task = FactoryBot.create(:second_task, title: 'タイトル2', due: "2023-02-07 11:48:00", user_id: @current_user.id)
        visit tasks_path
        click_on '終了期限順▼'
        sleep(2)
        task_list = all('.task_row')
          expect(task_list[0]).to have_content 'タイトル1'
          expect(task_list[1]).to have_content 'タイトル2'
      end
    end

    context 'タスクが優先順位昇順に並んでいる場合' do
      it '高のタスクが順に表示される' do
        task = FactoryBot.create(:task, title: 'タイトル1', priority_level: "高", user_id: @current_user.id)
        task = FactoryBot.create(:second_task, title: 'タイトル2', priority_level: "中", user_id: @current_user.id)
        # task = FactoryBot.create(:task)
        # task = FactoryBot.create(:second_task)
        visit tasks_path
        click_on '優先度順▼'
        sleep(2)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル1'
        expect(task_list[1]).to have_content 'タイトル2'
      end
    end

  end
   

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, title: 'task', content: 'task', user_id: @current_user.id)
          visit tasks_path
          click_on '詳細', match: :first
          expect(page).to have_content 'task'
        end
     end     
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task", status: "未着手", user_id: @current_user.id)
      FactoryBot.create(:second_task, title: "sample", status: "着手中", user_id: @current_user.id)
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[title]', with: 'task'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: 'task_status'
        click_on '検索'
        expect(page).to have_content '未着手'

      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[title]', with: 'task'
        select '未着手', from: 'task_status'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end
  end
end
