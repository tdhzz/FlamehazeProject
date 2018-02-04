module V1
  module Articles
    class CreateAction < Grape::API
      resource 'articles' do
        desc '创建新文章' do
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
          requires :content, type: String, allow_blank: false, desc: '文章内容'
        end

        post 'create' do
          Article.create_new params
        end
      end
    end
  end
end