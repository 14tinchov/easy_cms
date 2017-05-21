module EasyCms
  module Generators
    class ModelGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)
      desc "This generator create a Namespace and Scaffold model to CMS"
      argument :namespace, :type => :string, :required => :true
      argument :model    , :type => :string, :required => :true

      def create_namespace
        generate "easy_cms:namespace #{namespace}"
      end

      def generate_model_controller
        file_name = "app/controllers/#{namespace}/#{model.pluralize}_controller.rb"
        template './controllers/model_controller.erb', file_name , options_params unless File.exist?(file_name)
      end

      def add_navegation
        path = build_path("templates/layouts/item_navegation.html.erb")
        insert_into_file "app/views/layouts/#{namespace}.html.erb", read_file(path), :after => "<!-- Easy CMS - nav - don't delete this line -->\n"
      end

      def generate_model_layouts
        file_name = "app/views/#{namespace}/#{model.pluralize}/index.html.rb"
        template './layouts/index.html.erb', file_name, options_params  unless File.exist?(file_name)
      end

    private
      def build_path(template_path)
        File.join(File.dirname(__FILE__), template_path)
      end

      def read_file(path)
        b = binding
        content = ERB.new(File.read(path)).result b
        content
      end

      def options_params
        {
          :namespace => namespace,
          :namespace_cap => namespace.capitalize,
          :model => model,
          :model_plu => model.pluralize,
          :model_cap => model.capitalize,
          :model_cap_plu => model.capitalize.pluralize
        }
      end
    end
  end
end
