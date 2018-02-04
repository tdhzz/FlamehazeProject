FactoryBot.define do
  factory :article do
    creator_id      '木之本樱'
    content         '百变小樱魔术卡'
    enabled         true
    read_times      Kernel::rand(100)
  end
end
