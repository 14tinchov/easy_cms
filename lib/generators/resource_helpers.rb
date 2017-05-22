module EasyCms
  module Generators
    module ResourceHelpers
      private
      def build_path(template_path)
        File.join(File.dirname(__FILE__), template_path)
      end

      def read_file(path)
        b = binding
        content = ERB.new(File.read(path)).result b
        content
      end

      def get_model_attributes(name_capitalize_model)
        eval("
          begin
            #{name_capitalize_model}.columns.inject([]) do |rtn, model|
              unless ['id', 'created_at', 'updated_at'].include?(model.name)
                rtn << { :name => model.name, :type => model.type }
              end
              rtn
            end
          rescue NameError => e
            return []
          end
        ")
      end
    end
  end
end
