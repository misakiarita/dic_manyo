require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  before do
    @current_user = User.find_by(email: "user2@gmail.com")
  end

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.create(title: '', content: '失敗テスト', user_id: @current_user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.create(title: '失敗テスト', content: '', user_id: @current_user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.create(title: 'テスト', content: 'テスト', user_id: @current_user.id)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', user_id: @current_user.id) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample", user_id: @current_user.id) }
    let!(:third_task) { FactoryBot.create(:third_task, title: "sample", user_id: @current_user.id) }

    context 'scopeメソッドでタイトルのあいまい検索をした場合'  do
      it "検索キーワードを含むタスクで絞り込まれる" do
      
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1

        #paramsの検索も考えとく
        # params =  {[:task]=>{[:title]=>"task", [:status]=>""}, "commit"=>"検索"}
        # expect(Task.title_search(params)).to include(task)
        # expect(Task.title_search(params)).not_to include(second_task)
        # expect(Task.title_search(params).count).to eq 1
      
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do

        expect(Task.status_search(1)).to include(second_task)
        expect(Task.title_search(1)).not_to include(task)
        expect(Task.status_search(1).count).to eq 2
       
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.status_search(1).title_search('sample')).to include(second_task)
        expect(Task.status_search(1).title_search('sample')).not_to include(task)
        expect(Task.status_search(1).count).to eq 2
      end
    end
  end

end
