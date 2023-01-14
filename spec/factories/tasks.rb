FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    content { 'タスク1' }
    due {Time.now}
    status {0}
    priority_level {0}
    user_id {'1'}
  end
  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'タスク2' }
    due {Time.now}
    status {1}
    priority_level {1}
    user_id {'1'}
  end
  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'タスク3' }
    due {Time.now}
    status {1}
    priority_level {2}
    user_id {'1'}
  end
end

