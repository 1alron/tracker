FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "task_#{n}" }
    description { "Default task description" }
    status { :new }
    exec_date { Date.tomorrow }
  end
end
