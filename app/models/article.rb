class Article < ActiveRecord::Base
  validates_presence_of :content, message: ErrorCode::ERR_ARTICLE_CONTENT_INVALID.to_s
  validates_presence_of :read_times, message: ErrorCode::ERR_ARTICLE_READ_TIMES_INVALID.to_s

  belongs_to  :user,    class_name: 'User', foreign_key: :creator_id
  has_many    :article_comments

  def self.create_new params
    Util.try_rescue do |response|
      User.find_by! id: params['creator_id'], enabled: true
      params['enabled'] = true
      params['read_times'] = 0
      article = Article.create!(params.slice *(column_names - %w[id created_at updated_at]))
      response['id'] = article.id
    end
  end

  def self.soft_delete params
    Util.try_rescue do |response|
      article = find_by! id: params['id'], creator_id: params['creator_id'], enabled: true
      article.update! enabled: false
    end
  end


end