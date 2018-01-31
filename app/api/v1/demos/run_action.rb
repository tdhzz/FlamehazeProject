module V1
  module Demos
    class RunAction < Grape::API
      desc "helloworld"
      resource 'demos' do
        get 'run' do
          Demo.run
        end
      end
    end
  end
end