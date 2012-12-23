class <%= app_name %>.<%= module_namespace %>.Routers extends Backbone.Router
	routes:
		"": "index"
		"<%= module_namespace.downcase %>": "index"

	index: ->
		console.log "run root module"
		console.log "run <%= module_namespace %>"
		new <%= app_name %>.<%= module_namespace %>.Views.Index()