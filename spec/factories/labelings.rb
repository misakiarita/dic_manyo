FactoryBot.define do
  factory :labeling do
    association :test_label
    association :label_task
  end

end
