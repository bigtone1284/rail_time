App.Views.StationDropDownView = Backbone.View.extend({
	
	el: '#station-list-view',
	
	events: {
		'click .line' : 'chooseLine'
	},
	
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.render);
	},
	
	render: function() {
		this.$("#station-dropdown").empty();
		$("#choose-station").remove();
		$("#choose-direction").remove();
		$("<h2 id='choose-station'>2. Choose a Station</h2>").insertAfter('h2');
		this.collection.each(this.renderStation, this);
	},
	
	renderStation: function(station) {
		var stationDropDownItem = new App.Views.StationDropDownItemView({ model: station });
		this.$('#station-dropdown').append(stationDropDownItem.$el);
	},
	
	chooseLine: function(event) {
		if (event !== undefined) { this.line = event.target.id };
		this.collection.fetchByLineName(this.line);
		$("#station-dropdown").removeClass();
		$("#station-dropdown").addClass(this.line);
		if (Backbone.history.getFragment().indexOf(this.line) === -1) {
			App.router.navigate(this.line);
		}
	}
	
});
