require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".create_new" do

    let(:params){
      {
        'name' => 'SaberMyKing',
        'enabled' => true,
        'uid' => '1234214124',
        'level' => '0'
      }
    }

    it "success" do
      rtn = User.create_new params
      p rtn
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
    end

    it "error" do

    end

  end




end
