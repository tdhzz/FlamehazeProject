require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".create_new" do

    let(:params){
      {
        'name' => 'SaberMyKing',
        'level' => 5
      }
    }

    it "success" do
      rtn = User.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      expect(rtn['id']).to be_present
      user = User.find rtn['id']
      expect(user.name).to eq params['name']
      expect(user.level).to eq params['level']
      expect(user.enabled).to eq true
      expect(user.uid).to be_present
    end

    it "success params level absent and fill in level 0" do
      params.delete 'level'
      rtn = User.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      expect(rtn['id']).to be_present
      user = User.find rtn['id']
      expect(user.level).to eq 0
    end

    it "error params name absent" do
      params.delete 'name'
      rtn = User.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end

    it "error user name already exist, new user can not be create" do
      FactoryBot.create :user, params
      rtn = User.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_USER_ALREADY_EXIST
    end
  end

  describe ".soft_delete" do
    it "success" do
      user = FactoryBot.create :user
      rtn = User.soft_delete user.slice(*%w[id uid])
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      user_after = User.find_by id: user.id
      expect(user_after).to be_present
      expect(user_after.enabled).to eq false
    end

    it "error the user does not exist or uid, id input error" do
      rtn = User.soft_delete 'id'=>100, 'uid'=>10000
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION

      user = FactoryBot.create :user
      delete_params = user.slice(*%w[id uid])
      delete_params['id'] += 1
      rtn = User.soft_delete delete_params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      user_after = User.find_by id: user.id
      expect(user_after).to be_present
      expect(user_after.enabled).to eq true
    end
  end


end
