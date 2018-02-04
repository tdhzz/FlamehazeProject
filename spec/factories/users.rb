FactoryBot.define do
  factory :user do
    name '木之本樱'
    enabled true
    uid   Kernel::rand(999999)
    level 0
  end
end
