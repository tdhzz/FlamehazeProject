Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_path = Rails.root.join('app', 'api').to_s
  Dir.foreach(api_path) do |version|
    next if ['.', '..'].include? version
    version_path = api_path + '/' + version
    if File.directory?(version_path)
      Dir.foreach(version_path) do |resource_name|
        next if ['.', '..'].include? resource_name
        resource_path = version_path + '/' + resource_name
        if File.directory?(resource_path)
          Dir.foreach(resource_path) do |action_file|
            if action_file[-10, 10] == '_action.rb'
              mount "#{version.camelize}::#{resource_name.camelize}::#{action_file[0..-4].camelize}".constantize => '/'
            end
          end
        end
      end
    end
  end

  mount GrapeSwaggerRails::Engine => '/docs'
end
