App.Views.UpdateView = Backbone.View.extend({
	el: '#station-list-view',
	station: undefined,
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.render);
	},
	renderUpdates: function() {
		this.$("#search_results").empty();
		this.collection.each(this.renderUpdate, this);
	},
	renderUpdate: function(update) {
		var updateListing = new App.Views.UpdateListingView({ model: update })
		this.$('#search_results').append(updateListing.$el);
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest'
	},
	chooseStation: function(event) {
		this.station = event.target.value
		$('#direction').removeAttr('hidden');
	},
	sendRequest: function(event) {
		var direction = event.target.id
		this.collection.fetchStationUpdates(this.station, direction);
	}
});