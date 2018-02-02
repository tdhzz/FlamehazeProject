class ArticleComment < ActiveRecord::Base
  validates_presence_of :content, message: ErrorCode::ERR_ARTICLE_COMMENT_CONTENT_INVALID.to_s

  belongs_to :article
  belongs_to :user,             class_name: 'Article',        foreign_key: :creator_id
  has_many   :son_comments,     class_name: 'ArticleComment', foreign_key: :parent_comment_id
  belongs_to :parent_comments,  class_name: 'ArticleComment', foreign_key: :parent_comment_id


end