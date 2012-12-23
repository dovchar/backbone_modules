require 'generators/bbm/helpers'

module Bbm
  module Generators
    module Add
      class ViewGenerator < Rails::Generators::NamedBase
        include Bbm::Generators::Helpers

        source_root File.expand_path("../templates", __FILE__)

        desc "Generates a Backbone.js resource add"

        class_option :javascript,
                      type: :boolean,
                      aliases: "-j",
                      default: false,
                      desc: "Generate JavaScript"

        def parse_options
          js = options.javascript
          @ext = js ? ".js" : ".js.coffee"
          @jst = js ? ".ejs" : ".eco"
        end

        def create_backbone_template
          empty_directory File.join(template_path, file_name.pluralize)
          file = File.join(template_path, file_name.pluralize, "index.jst#{@jst}")
          template "template.jst#{@jst}", file
        end
      end
    end
  end
end
