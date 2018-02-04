require 'rails_helper'

RSpec.describe Article, type: :model do

  describe ".create_new" do

    let(:params){
      {
          # invalid user id
          'creator_id' => '1000',
          'content' => '1234214124',
      }
    }

    let(:user){
      FactoryBot.create :user
    }

    it "success" do
      params['creator_id'] = user.id
      rtn = Article.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      expect(rtn['id']).to be_present
      article = Article.find rtn['id']
      expect(article['creator_id']).to eq params['creator_id']
      expect(article['content']).to eq params['content']
      expect(article['enabled']).to eq true
      expect(article['read_times']).to eq 0
    end

    it "error article user does not exist" do
      rtn = Article.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      params.delete 'creator_id'
      rtn = Article.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end

    it "error params content absent" do
      params.delete 'content'
      rtn = Article.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end
  end

  describe ".soft_delete" do

    let(:user){
      FactoryBot.create :user
    }

    it "success" do
      article = FactoryBot.create :article, creator_id: user.id
      rtn = Article.soft_delete article.slice(*%w[id creator_id])
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      article_after = Article.find article['id']
      expect(article_after.enabled).to eq false
    end

    it "error" do
      article = FactoryBot.create :article, creator_id: user.id
      rtn = Article.soft_delete 'id'=>article.id+1
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      rtn = Article.soft_delete 'id'=>article.id+1, 'creator_id'=>12345667
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      rtn = Article.soft_delete 'id'=>article.id+1, 'creator_id'=>article.creator_id
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end
  end
end
