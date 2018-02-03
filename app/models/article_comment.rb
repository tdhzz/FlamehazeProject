class ArticleComment < ActiveRecord::Base
  validates_presence_of :content, message: ErrorCode::ERR_ARTICLE_COMMENT_CONTENT_INVALID.to_s

  belongs_to :article
  belongs_to :user,             class_name: 'Article',        foreign_key: :creator_id
  has_many   :son_comments,     class_name: 'ArticleComment', foreign_key: :parent_comment_id
  belongs_to :parent_comments,  class_name: 'ArticleComment', foreign_key: :parent_comment_id

  def self.create_new params
    Util.try_rescue do |response|
      User.find_by! id: params['creator_id'], enabled: true
      Article.find_by! id: params['article_id'], enabled: true
      article_comment = ArticleComment.new(params.slice *(column_names - %w[id created_at updated_at]))
      article_comment.save!
      response['id'] = article_comment.id
    end
  end

  def self.soft_delete params
    Util.try_rescue do |response|
      article_comment = find_by! id: params['id'], article_id: params['article_id'], enabled: true
      article_comment.update! enabled: false
    end
  end

end