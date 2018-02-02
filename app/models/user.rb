class User < ActiveRecord::Base
  validates_presence_of :name, message: ErrorCode::ERR_USER_NAME_INVALID.to_s
  validates_presence_of :uid, message: ErrorCode::ERR_USER_UID_INVALID.to_s

  has_many :articles,          class_name: 'Article',        foreign_key: :creator_id
  has_many :articles_comments, class_name: 'ArticleComment', foreign_key: :creator_id



end