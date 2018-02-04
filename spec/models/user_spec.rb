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
      FactoryBot.create :user

    end

  end




end
