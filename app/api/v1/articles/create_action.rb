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
          optional :enabled, type: Boolean, desc: '是否被禁用'
          optional :read_times, type: Integer, desc: '阅读次数'
        end

        post 'create' do
          Article.create_new params
        end
      end
    end
  end
end