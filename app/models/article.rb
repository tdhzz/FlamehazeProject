class Article < ActiveRecord::Base
  validates_presence_of :content, message: ErrorCode::ERR_ARTICLE_CONTENT_INVALID.to_s
  validates_presence_of :read_times, message: ErrorCode::ERR_ARTICLE_READ_TIMES_INVALID.to_s

  belongs_to  :user,    class_name: 'User', foreign_key: :creator_id
  has_many    :article_comments

  def self.create_new params
    response = {
        'return_code'=>0
    }
  end

  def self.soft_delete params

  end


end