module Util
  def self.do_request
    result_json = {}
    begin
      result_json = yield
    rescue => e
      Rails.logger.error e
      result_json = CommonException.new(ErrorCode::ERR_SYSTEM_EXCEPTION, e.message).result
    end
    result_json
  end

  # 捕获异常块
  def self.try_rescue
    response = CommonException.new(ErrorCode::SUCCESS).result
    begin
      yield(response) if block_given?
    rescue CommonException => e
      Rails.logger.error e.backtrace
      Rails.logger.error e
      response = e.result
    rescue Exception => e
      Rails.logger.error e.backtrace
      Rails.logger.error e
      response = CommonException.new(ErrorCode::ERR_SYSTEM_EXCEPTION, e.message).result
    end
    response.as_json
  end
end
