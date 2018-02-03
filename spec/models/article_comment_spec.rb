require 'rails_helper'

RSpec.describe ArticleComment, type: :model do

  describe ".create_new" do

    let(:params){
      {
          'name' => 'SaberMyKing',
          'enabled' => true,
          'content' => '1234214124',
          'read_times' => '0'
      }
    }

    it "success" do
      rtn = Article.create_new params
      p rtn
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
    end

    it "error" do

    end

  end




end
