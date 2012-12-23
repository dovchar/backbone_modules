module Bbm
  module Generators
    module Helpers

      def asset_path
        File.join('app', 'assets')
      end

      def javascript_path
        File.join(asset_path, 'javascripts')
      end

      #TODO: refactor model_path, collection_path, router_path, view_path
      def model_path
        File.join(javascript_path, "#{@module_name}/models")
      end

      def collection_path  
        File.join(javascript_path, "#{@module_name}/collections")
      end

      def router_path
        File.join(javascript_path, "#{@module_name}/routers")
      end

      def view_path
        File.join(javascript_path, "#{@module_name}/views")
      end

      def template_path
        File.join(asset_path, "templates")
      end

      def module_path(module_name)
        @module_name = module_name
        File.join(javascript_path, "#{module_name}")
      end

      def singular_file_name
        "#{file_name.singularize}#{@ext}"
      end

      def plural_file_name
        "#{file_name.pluralize}#{@ext}"
      end

      def router_file_name
        "#{@module_name.pluralize}_router#{@ext}"
      end

      def view_file_name
        "#{file_name.pluralize}_index#{@ext}"
      end

      def model_namespace
        [app_name, "Models", file_name.singularize.camelize].join(".")
      end

      def collection_namespace
        [app_name, "Collections", file_name.pluralize.camelize].join(".")
      end

      def router_namespace
        
        #[app_name, "Routers", file_name.pluralize.camelize].join(".")
      end

      def view_namespace
        [app_name, "Views", "#{file_name.pluralize.camelize}Index"].join(".")
      end

      def template_namespace
        File.join(file_path.pluralize, "index")
      end

      def app_name
        rails_app_name.camelize
      end

      def module_namespace
        @module_name.camelize
      end

      def app_filename
        rails_app_name.underscore
      end

      def rails_app_name
        Rails.application.class.name.split('::').first
      end

      def out_modules
        out = []
        out << "\n"
        out << "  #{module_namespace}: {}"
        out = out.join("")
      end

      def init_modules
        init = []
        init << "\n"
        init << "  #{rails_app_name}.#{module_namespace}.initialize()"
        init = init.join("")
      end
      
      def init_router
        init = []
        init << "\n"
        init << "    new #{app_name}.#{module_namespace}.Routers()"
        init = init.join("")
      end
    end
  end
end
