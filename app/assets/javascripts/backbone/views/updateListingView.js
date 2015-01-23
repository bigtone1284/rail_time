App.Views.UpdateListingView = Backbone.View.extend({
	class: 'update-listing',
	initialize: function() {
		this.template = HandlebarsTemplates['updateListing'];
		this.render();
	},
	render: function() {
		debugger
    this.$el.html(this.template(this.model.toJSON()));
  },
  events: {

  }  
});