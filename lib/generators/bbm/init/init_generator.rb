require 'generators/bbm/helpers'

module Bbm
  module Generators
    class InitGenerator < Rails::Generators::Base
      include Bbm::Generators::Helpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a Backbone.js module skeleton directory structure and manifest"

      #TODO: refactor class options
      class_option :javascript,
                    type: :boolean,
                    aliases: "-j",
                    default: false,
                    desc: "Generate JavaScript"

      class_option :validation,
                    type: :boolean,
                    aliases: "-v",
                    default: false,
                    desc: "Create Backbone.Validation pluggin for application"
      
      class_option :module_name,
                    type: :string,
                    aliases: "-m",
                    desc: "Create sub application folder"

      class_option :binder,
                    type: :boolean,
                    aliases: "-b",
                    default: false,
                    desc: "Create Backbone.ModelBinder pluggin for application"

      class_option :router_root,
                    type: :boolean,
                    aliases: "--root",
                    default: false,
                    desc: "Create root router for this module"

      # class_option :associations,
      #               type: :boolean,
      #               aliases: "-a",
      #               default: '',
      #               desc: "Create Backbone.Associations pluggin for application"              

      class_option :manifest,
                    type: :string,
                    aliases: "-e",
                    default: "application.js",
                    desc: "Javascript manifest file to modify (or create)"

      def create_dir_layout
        #TODO: refactor this code
        begin
          if !options.module_name.empty?
            empty_directory module_path options.module_name
            empty_directory model_path
            empty_directory collection_path
            empty_directory router_path
            empty_directory view_path
            empty_directory template_path
          end
        rescue Exception => e
          puts 'Please add backbone module name: rails g bbm:install --module YOUR_MODULE_NAME'  
        end
      end

      def create_app_file
        js = options.javascript
        @ext = js ? ".js" : ".js.coffee"

        if File.exists?("#{javascript_path}/#{app_filename}#{@ext}")
          inject_into_file("#{javascript_path}/#{app_filename}#{@ext}", out_modules, after: "window.#{app_name} =")
          inject_into_file("#{javascript_path}/#{app_filename}#{@ext}", init_modules, after: "$(document).ready ->")
        else 
          template "app#{@ext}", "#{javascript_path}/#{app_filename}#{@ext}"
        end
      end

      def create_module_file
        template "module#{@ext}", "#{javascript_path}/#{@module_name}/#{@module_name}#{@ext}"
      end

      def create_module_router
        router = options.router_root
        router_tpl = router ? "root_router" : "router"
        template "#{router_tpl}#{@ext}", "#{router_path}/#{@module_name}_router#{@ext}"
        inject_into_file("#{javascript_path}/#{@module_name}/#{@module_name}#{@ext}", init_router, after: "initialize: ->")
      end
      
      def create_module_view
        template "index_view#{@ext}", "#{view_path}/index_view#{@ext}"
      end
      
      def create_module_collection
        template "index_collection#{@ext}", "#{collection_path}/index_collection#{@ext}"
      end
      
      def create_module_model
        template "index_model#{@ext}", "#{model_path}/index_model#{@ext}"
      end
      
      def create_module_template
        empty_directory File.join(template_path, @module_name)
        file = File.join(template_path, @module_name, "index.jst#{@jst}")
        template "template.jst.eco", "#{template_path}/#{@module_name}/index.jst.eco"
      end
      
      def create_module_tests
        empty_directory test_path
        empty_directory model_test_path
        empty_directory collection_test_path
        empty_directory router_test_path
        empty_directory view_test_path
        template "module_spec.js.coffee", "#{test_path}/#{@module_name}_spec.js.coffee"
        template "spec.js.coffee", "spec/spec.js.coffee"
      end
      
      #TODO: refactor this method
      def inject_backbone
        manifest = File.join(javascript_path, options.manifest)
        libs = %w(underscore backbone)
        
        if options.validation
          libs += %w(backbone-validation)
        end
        
        if options.binder
          libs += %w(backbone-model-binder)
        end
         
        paths = ['../templates', "./#{@module_name}/models", "./#{@module_name}/collections", "./#{@module_name}/views", "./#{@module_name}/routers"]
        
        #TODO: refactor this strange code!!!
        f = File.open(manifest).read()
        require_module_name = "//= require #{app_filename}"
        if f =~ /#{require_module_name}/ then
          out = []
          out << "\n//= require ./#{@module_name}/#{@module_name}"
          out << paths.map{ |path| "//= require_tree #{path}" }
          out = out.join("\n")
          in_root do
            create_file(manifest) unless File.exists?(manifest)
            if File.open(manifest).read()
              inject_into_file(manifest, out, after: "//= require #{app_filename}")
            else
              append_file(manifest, out)
            end
          end
        else
          out = []
          out << libs.map{ |lib| "//= require #{lib}" }
          out << "//= require #{app_filename}"
          out << "//= require ./#{@module_name}/#{@module_name}"
          out << paths.map{ |path| "//= require_tree #{path}" }
          out = out.join("\n") + "\n"
          in_root do
            create_file(manifest) unless File.exists?(manifest)
            if File.open(manifest).read().include?('//= require_tree')
              inject_into_file(manifest, out, before: '//= require_tree')
            else
              append_file(manifest, out)
            end
          end    
        end    
      end

    end
  end
end
