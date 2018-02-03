module Util
  def self.do_request
    result_json = {}
    begin
      result_json = yield
    rescue => e
      Log.error e
      result_json = UndifineException.new(e.message).result
    end
    result_json
  end

  # 捕获异常块
  def self.try_rescue
    response = CommonException.new(ErrorCode::SUCCESS).result
    begin
      yield(response) if block_given?
    rescue CustomException => e
      print_backtrace e
      Log.error e
      response = e.result
    rescue Exception => e
      print_backtrace e
      Log.error e
      response = UndifineException.new(e.message).result
    end
    response.as_json
  end
end