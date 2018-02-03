module V1
  module ArticleComments
    class CreateAction < Grape::API
      resource 'article_comments' do
        desc '创建新文章评论' do
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
          requires :article_id, type: Integer, allow_blank: false, desc: '被评论的文章ID'
          requires :creator_id, type: Integer, allow_blank: false, desc: '创建者ID'
          requires :content, type: String, allow_blank: false, desc: '评论内容'
          requires :parent_comment_id, type: Integer, allow_blank: false, desc: '父评论ID（评论的评论才有此值）'
          optional :enabled, type: Boolean, desc: '是否被禁用'
        end

        post 'create' do
          ArticleComment.create_new params
        end
      end
    end
  end
end