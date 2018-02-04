class CommonException < Exception

  attr_accessor :error_code, :error_info

  def initialize error_code, error_info = nil
    @error_code = error_code
    @error_info = error_info
    if error_info.nil?
      error_info_yml = YAML::load(File.read("#{Rails.root}/config/return_code/error_info.yml"))['error_info'] || {}
      @error_info = error_info_yml[error_code.to_i] || ''
    end
    super error_code
  end

  def result
    {
        'return_code' => @error_code,
        'return_info' => @error_info
    }
  end

end
