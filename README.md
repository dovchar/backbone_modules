# Vaka

TODO: Please do not use this gem! It's not ready for prodaction
This gem used new backbone 0.9.9

## Installation

Add this line to your application's Gemfile:

    gem 'vaka'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vaka

## Usage

Include gem vaka to rails Gemfile:
	
	
	$ gem "vaka", :git => 'git@github.com:dovchar/vaka.git'
	$ bundle install

Initialize you application:

	$ rails g bbm:init -m your_module_name -v -b -a --root

###Options:

-v include backbone validation plugin (http://github.com/thedersen/backbone.validation)

-b include backbone model binder (https://github.com/theironcook/Backbone.ModelBinder)

-a include backbone association (http://github.com/DreamTheater/Backbone.Associations)

--root add root backbone path

##Example:

Create your rails application:

	$ rails new app

Open your Gemfile and add:

	$ gem "vaka", :git => 'git@github.com:dovchar/vaka.git'

and run:

	$ bundle install

after you should create rails controller:

	$ rails g controller home

open rails router config and this lines:

	Family::Application.routes.draw do
	  scope 'api' do
	    resources :entries
	  end 
	  root to: 'home#index'
	  match '*path', to: 'home#index'
	end

ok now we have rails application and rails controller so lets start create backbone application:

	$ rails g bbm:init -m posts --root
		  create  app/assets/javascripts/posts
		  create  app/assets/javascripts/posts/models
	      create  app/assets/javascripts/posts/collections
	      create  app/assets/javascripts/posts/routers
	      create  app/assets/javascripts/posts/views
	       exist  app/assets/templates
	      insert  app/assets/javascripts/app.js.coffee
	      insert  app/assets/javascripts/app.js.coffee
	      create  app/assets/javascripts/posts/posts.js.coffee
	      create  app/assets/javascripts/posts/routers/posts_router.js.coffee
	      insert  app/assets/javascripts/posts/posts.js.coffee
	      create  app/assets/javascripts/posts/views/index_view.js.coffee
	      create  app/assets/javascripts/posts/collections/index_collection.js.coffee
	      create  app/assets/javascripts/posts/models/index_model.js.coffee
	      create  app/assets/templates/posts
	      create  app/assets/templates/posts/index.jst.eco
	      insert  app/assets/javascripts/application.js	

so in app/assets/javascripts/application.js you could see created lines:

	//= require underscore
	//= require backbone
	//= require app
	//= require ./posts/posts
	//= require_tree ../templates
	//= require_tree ./posts/models
	//= require_tree ./posts/collections
	//= require_tree ./posts/views
	//= require_tree ./posts/routers

file that created like your rails application name: your_rails_app_name it is main javascript file of your applcation:

	$window.App =
	  Posts: {}
	  Module2: {}
	  Module3: {}
	  View: null
	$(document).ready ->
	  App.Posts.initialize()
	  App.Module2.initialize()
	  App.Module3.initialize()
	  Backbone.history.start pushState: true

file that created in app/assets/javascripts/posts/posts.js.coffee it is your main module javascript file:

	App.Home = 
	  Models: {}
	  Collections: {}
	  Views: {}
	  Routers: {}
	  initialize: ->
	    new App.Home.Routers()

file app/assets/javascripts/posts/routers/posts_router.js.coffee:

	class App.Posts.Routers extends Backbone.Router
		routes:
			"": "index"
			"posts": "index"
		index: ->
			console.log "run Posts"
			new App.Posts.Views.Index()

file app/assets/javascripts/posts/views/index_view.js.coffee:

	class App.Posts.Views.Index extends Backbone.View
	  template: JST['posts/index']

	  initialize: ->
		  console.log "this is posts view"
		  @render()
	  render: ->
	    #Implement id element
	    #$(@el).html(@template())
	    #$('#posts').html(this.el)
	    this

##Future

1. Support javascript
2. Create unit tests structure

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request