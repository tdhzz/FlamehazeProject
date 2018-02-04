module V1
  module Users
    class CreateAction < Grape::API
      resource 'users' do
        desc '创建新用户' do
          detail %(
# 返回值:
```ruby
{
  "return_code" : 0,
  "return_info" : "success"
}
```
)
        end

        params do
          requires :name, type: String, allow_blank: false, desc: '用户昵称'
          requires :level, type: Integer, allow_blank: true, desc: '用户等级'
        end

        post 'create' do
          User.create_new params
        end
      end
    end
  end
end