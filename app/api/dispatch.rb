module Api
  class Dispatch < Grape::API

    def self.mount_resource_and_action
      current_path = File.dirname(__FILE__)
      Dir.foreach(current_path) do |version|
        next if ['.', '..'].include? version
        version_path = current_path + '/' + version
        if File.directory?(version_path)
          Dir.foreach(version_path) do |resource_name|
            next if ['.', '..'].include? resource_name
            resource_path = version_path + '/' + resource_name
            if File.directory?(resource_path)
              Dir.foreach(resource_path) do |action_file|
                if action_file[-10, 10] == '_action.rb'
                  mount "#{version.camelize}::#{resource_name.camelize}::#{action_file[0..-4].camelize}".constantize
                end
              end
            end
          end
        end
      end

      add_swagger_documentation(
          hide_documentation_path: true,
          hide_format: true
      )
    end

    mount_resource_and_action
  end
end