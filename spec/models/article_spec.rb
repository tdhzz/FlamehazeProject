require 'rails_helper'

RSpec.describe Article, type: :model do

  describe ".create_new" do

    let(:params){
      {
          'creator_id' => '1',
          'enabled' => true,
          'content' => '1234214124',
          'read_times' => '0'
      }
    }

    it "success" do
      rtn = Article.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
    end

    it "error" do

    end

  end




end
