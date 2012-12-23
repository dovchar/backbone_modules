window.<%= app_name %> =
  <%= module_namespace %>: {}
  View: null

$(document).ready ->
  <%= app_name %>.<%= module_namespace %>.initialize()
  Backbone.history.start pushState: true
  