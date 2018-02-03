class User < ActiveRecord::Base
  validates_presence_of :name, message: ErrorCode::ERR_USER_NAME_INVALID.to_s
  validates_presence_of :uid, message: ErrorCode::ERR_USER_UID_INVALID.to_s
  validates_presence_of :level, message: ErrorCode::ERR_USER_LEVEL_INVALID.to_s

  has_many :articles,          class_name: 'Article',        foreign_key: :creator_id
  has_many :articles_comments, class_name: 'ArticleComment', foreign_key: :creator_id

  def self.create_new params
    Util.try_rescue do |response|
      user_exist = User.find_by name: params['name'], enabled: true
      return response if user_exist.present?
      user = User.new(params.slice *(column_names - %w[id created_at updated_at]))
      user.save!
      response['id'] = user.id
    end
  end

  def self.soft_delete params
    Util.try_rescue do |response|
      user = find_by! id: params['id'], uid: params['uid'], enabled: true
      user.update! enabled: false
    end
  end


end