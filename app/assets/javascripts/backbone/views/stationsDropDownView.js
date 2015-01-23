App.Views.StationDropDownView = Backbone.View.extend({
	el: 'select #stationList',
	initialize: function() {
		console.log("fillling it up the drop down");
	},
	render: function() {
		this.collection.each(this.renderStation, this);
	},
	renderStation: function() {
		var stationDropDownItem = new App.Views.StationDropDownItemView({ model: station })
		this.$('#station-dropdown').append(stationDropDownItem.$el);
	},
	events: {
		'click .line' : 'chooseLine'
	},
	chooseLine: function() {
		debugger
		var line = $this.attr.val()
		this.stations.fecthByLineName(line)
	}
});