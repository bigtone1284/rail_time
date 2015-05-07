App.Views.StationDropDownItemView = Backbone.View.extend({
	class: 'stationDropDownItem',
	initialize: function() {
		this.template = HandlebarsTemplates['stationDropDownItem'];
		this.render();
	},
	render: function() {
    this.$el.html(this.template(this.model.toJSON()));
  },
  events: {

  }  
});
