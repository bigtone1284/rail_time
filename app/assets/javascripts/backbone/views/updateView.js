App.Views.UpdateView = Backbone.View.extend({
	el: '#station-list-view',
	station: undefined,
	direction: undefined,
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.renderUpdates);
	},
	renderUpdates: function() {
		this.$('modal').removeAttr('hidden')
		this.renderTableHeader();
		this.collection.each(this.renderUpdate, this);
	},
	renderUpdate: function(update) {
		var updateListing = new App.Views.UpdateListingView({ model: update });
		this.$("table tbody").append(updateListing.$el.children());
	},
	renderTableHeader: function() {
		this.$('#station-table-header').text("Arrivals for " + App.stations.where({stop_id: this.station})[0].get("stop_name") + " going " + this.direction.charAt(0).toUpperCase() + this.direction.slice(1))
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest',
		'click #save-alert-click': 'saveAlert'
	},
	chooseStation: function(event) {
		this.station = event.target.value
		$('#direction').removeAttr('hidden');
	},
	sendRequest: function(event) {
		this.$(".update-listing").remove()
		this.direction = event.target.id
		this.collection.fetchStationUpdates(this.station, this.direction);
	},
	saveAlert: function() {
		var stop = App.stations.findWhere({stop_id: this.station}).id;
		var email = $('input[type=text]').val();
		var time = $('input[type=time]').val();
		var alert = {
			
		}
		$.ajax({
		  type: "POST",
		  url: url,
		  data: data,
		  success: success,
		  dataType: dataType
		});
	}
});