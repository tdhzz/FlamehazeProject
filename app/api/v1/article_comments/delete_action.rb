module V1
  module ArticleComments
    class DeleteAction < Grape::API
      resource 'article_comments' do
        desc '删除文章评论' do
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
          requires :id, type: Integer, allow_blank: false, desc: '评论ID'
          requires :article_id, type: Integer, allow_blank: false, desc: '被评论的文章ID'
        end

        post 'delete' do
          ArticleComment.soft_delete params
        end
      end
    end
  end
end