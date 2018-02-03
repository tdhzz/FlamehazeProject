class User < ActiveRecord::Base
  validates_presence_of :name, message: ErrorCode::ERR_USER_NAME_INVALID.to_s
  validates_presence_of :uid, message: ErrorCode::ERR_USER_UID_INVALID.to_s
  validates_presence_of :level, message: ErrorCode::ERR_USER_LEVEL_INVALID.to_s

  has_many :articles,          class_name: 'Article',        foreign_key: :creator_id
  has_many :articles_comments, class_name: 'ArticleComment', foreign_key: :creator_id

  def self.create_new params
    Util.try_rescue do |response|
      user_exist = User.find_by name: params['name'], enabled: true
      return CommonException.new(ErrorCode::ERR_USER_ALREADY_EXIST).result if user_exist.present?
      # 创建的新用户默认为启用的，且等级为0
      params['enabled'] = true
      params['level'] = 0
      user = User.create!(params.slice *(column_names - %w[id created_at updated_at]))
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