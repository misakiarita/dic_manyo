require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
        task = FactoryBot.create(:task, title: 'タイトル1', content: 'コンテント1')
        visit tasks_path
        expect(page).to have_content 'タイトル1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
      task = FactoryBot.create(:task, title: 'タイトル1')
      task = FactoryBot.create(:second_task, title: 'タイトル2')

      visit tasks_path
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'タイトル2'
      expect(task_list[1]).to have_content 'タイトル1'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
      task = FactoryBot.create(:task, title: 'タイトル1', due: "2023-02-10 11:48:00")
      task = FactoryBot.create(:second_task, title: 'タイトル2', due: "2023-02-07 11:48:00")
      visit tasks_path
      click_on '終了期限でソートする'
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'タイトル1'
      expect(task_list[1]).to have_content 'タイトル2'
      end
    end

   end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, title: 'task', content: 'task')
          visit tasks_path
          click_on '詳細', match: :first
          expect(page).to have_content 'task'
        end
     end     
  end
end
