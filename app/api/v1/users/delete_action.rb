module V1
  module Users
    class DeleteAction < Grape::API
      resource 'users' do
        desc '删除用户' do
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
          requires :id, type: Integer, allow_blank: false, desc: '用户ID'
          requires :uid, type: Integer, allow_blank: false, desc: 'UID码'
        end

        post 'delete' do
          User.soft_delete params
        end
      end
    end
  end
end