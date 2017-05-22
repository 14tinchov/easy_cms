require 'generators/resource_helpers'

module EasyCms
  module Generators
    class NamespaceGenerator < Rails::Generators::Base
      include ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)
      desc "This generator create a Namespace to CMS"
      argument :namespace, :type => :string, :required => :true

      def generate_base_controller
        file_name = "app/controllers/#{namespace}/base_controller.rb"
        template './controllers/base_controller.erb', file_name, options_params unless File.exist?(file_name)
      end

      def generate_layout
        file_name = "app/views/layouts/#{namespace}.html.erb"
        template "./layouts/layout.html.erb", file_name, options_params unless File.exist?(file_name)
      end

      def generate_assets
        file_name_js = "app/assets/javascripts/#{namespace}.js"
        file_name_stylesheet = "app/assets/stylesheets/#{namespace}.scss"

        template "./assets/base_javascript.erb", file_name_js   unless File.exist?(file_name_js)
        template "./assets/base_scss.erb", file_name_stylesheet unless File.exist?(file_name_stylesheet)
      end

      def add_initializers_assets
        prepend_to_file 'config/initializers/assets.rb' do 
          "Rails.application.config.assets.precompile += %w( #{namespace}.js )\n"
        end
        prepend_to_file 'config/initializers/assets.rb' do 
          "Rails.application.config.assets.precompile += %w( #{namespace}.scss )\n"
        end
      end

    private
      def options_params
        { :namespace => namespace }
      end
    end
  end
end
