FactoryBot.define do

  factory :user do
    name '木之本樱'
    enabled true
    uid   Kernel::rand(100)
    level 0
  end
end
