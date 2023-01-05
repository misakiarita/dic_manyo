FactoryBot.define do
  factory :task do
    title { 'タスク1' }
    content { 'タスク1' }
  end
  factory :second_task, class: Task do
    title { 'タスク2' }
    content { 'タスク2' }
  end
end

