FactoryBot.define do
  factory :user do
    name      '木之本樱'
    enabled   true
    uid       rand(10)
    level     0
  end
end
