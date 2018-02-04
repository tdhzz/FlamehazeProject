require 'rails_helper'

RSpec.describe ArticleComment, type: :model do

  describe ".create_new" do

    let(:params){
      {
          'article_id' => 1000,
          'creator_id' => 1000,
          'content' => '1234214124',
      }
    }

    it "success" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      params['article_id'] = article.id
      params['creator_id'] = user.id
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      expect(rtn['id']).to be_present
      article_comment = ArticleComment.find rtn['id']
      expect(article_comment.slice *params.keys).to eq params
    end

    it "error params article id and creator id absent or invalid" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      params['article_id'] = article.id
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      params['article_id'] = 1000
      params['creator_id'] = user.id
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end

    it "error params content absent" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      params['article_id'] = article.id
      params['creator_id'] = user.id
      params.delete 'content'
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
    end

    it "success params with parent_comment_id" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      parent_comment = FactoryBot.create :article_comment, creator_id: user.id, article_id: article.id
      params['article_id'] = article.id
      params['creator_id'] = user.id
      params['parent_comment_id'] = parent_comment.id
      rtn = ArticleComment.create_new params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      comment_after = ArticleComment.find rtn['id']
      expect(comment_after.parent_comment_id).to eq params['parent_comment_id']
    end
  end

  describe ".soft_delete" do
    let(:params){
      {
          'id'=>1000,
          'article_id'=>1000
      }
    }

    it "success" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      comment = FactoryBot.create :article_comment, creator_id: user.id, article_id: article.id
      params['article_id'] = article.id
      params['id'] = comment.id
      rtn = ArticleComment.soft_delete params
      expect(rtn['return_code']).to eq ErrorCode::SUCCESS
      comment_after = ArticleComment.find comment.id
      expect(comment_after.enabled).to eq false
    end

    it "error" do
      user = FactoryBot.create :user
      article = FactoryBot.create :article, creator_id: user.id
      comment = FactoryBot.create :article_comment, creator_id: user.id, article_id: article.id
      params['id'] = comment.id
      rtn = ArticleComment.soft_delete params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      params['id'] = 1000
      params['article_id'] = article.id
      rtn = ArticleComment.soft_delete params
      expect(rtn['return_code']).to eq ErrorCode::ERR_SYSTEM_EXCEPTION
      comment_after = ArticleComment.find comment.id
      expect(comment_after.enabled).to eq true
    end

  end

end
