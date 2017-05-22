require 'generators/resource_helpers'

module EasyCms
  module Generators
    class ModelGenerator < Rails::Generators::Base
      include ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)
      desc "This generator create a Namespace and Scaffold model to CMS"
      argument :namespace, :type => :string, :required => :true
      argument :model    , :type => :string, :required => :true

      def create_namespace
        generate "easy_cms:namespace #{namespace}"
      end

      def generate_model_controller
        file_name = "app/controllers/#{namespace}/#{model.pluralize}_controller.rb"
        template './controllers/model_controller.erb', file_name, options_params
      end

      def add_navegation
        path = build_path("easy_cms/model/templates/layouts/item_navegation.html.erb")
        insert_into_file "app/views/layouts/#{namespace}.html.erb", read_file(path), :after => "<!-- Easy CMS - nav - don't delete this line -->\n"
      end

      def generate_model_layouts
        generate_action_layout('index')
        generate_action_layout('show')
        generate_action_layout('new')
        generate_action_layout('edit')
        generate_action_layout('_form')
      end

      def generate_route
        easy_cms_route = %Q(namespace :#{namespace} do\n    resources :#{model.pluralize}\n  end)
        route easy_cms_route
      end

    private
      def generate_action_layout(action)
        file_name = "app/views/#{namespace}/#{model.pluralize}/#{action}.html.erb"
        template "./layouts/#{action}.html.erb", file_name, options_params
      end

      def model_attributes
        @model_attributes ||= get_model_attributes(options_params[:model_cap])
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

      def build_params_controller
        return '' unless model_attributes.any?
        params = ''
        model_attributes.each do |a|
          params += a != model_attributes.last ? ":#{a[:name]}, " : ":#{a[:name]}"
        end
        params
      end
    end
  end
end
