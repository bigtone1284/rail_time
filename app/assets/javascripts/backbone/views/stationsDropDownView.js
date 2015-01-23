App.Views.StationDropDownView = Backbone.View.extend({
	el: '#station-list-view',
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.render);
	},
	render: function() {
		this.$("#station-dropdown").empty();
		this.collection.each(this.renderStation, this);
	},
	renderStation: function(station) {
		var stationDropDownItem = new App.Views.StationDropDownItemView({ model: station })
		this.$('#station-dropdown').append(stationDropDownItem.$el);
	},
	events: {
		'click .line' : 'chooseLine'
	},
	chooseLine: function(event) {
		var line = event.target.id
		this.collection.fetchByLineName(line)
	}
});