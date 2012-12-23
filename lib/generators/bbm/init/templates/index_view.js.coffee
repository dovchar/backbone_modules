class <%= app_name %>.<%= module_namespace %>.Views.Index extends Backbone.View
  template: JST['<%= module_namespace.downcase %>/index']
  
  initialize: ->
	  console.log "this is <%= module_namespace.downcase %> view"
	  @render()
	
  render: ->
    #Implement id element
    #$(@el).html(@template())
    #$('#<%= module_namespace.downcase %>').html(this.el)
    this