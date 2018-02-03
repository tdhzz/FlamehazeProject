module V1
  module Articles
    class DeleteAction < Grape::API
      resource 'articles' do
        desc '删除文章' do
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
          requires :creator_id, type: Integer, allow_blank: false, desc: '创建者ID'
          requires :id, type: Integer, allow_blank: false, desc: '文章ID'
        end

        post 'delete' do
          Article.soft_delete params
        end
      end
    end
  end
end