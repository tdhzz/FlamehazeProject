class ArticlesController < ActionController::Base

  def create_new
    rtn = Article.create_new params
    render json: rtn unless rtn['return_code'] == ErrorCode::SUCCESS
  end

end