App.Views.UpdateView = Backbone.View.extend({
	el: '#station-list-view',
	station: undefined,
	direction: undefined,
	user: undefined,
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.renderUpdates);
	},
	renderUpdates: function() {
		this.$("table").removeAttr('hidden');
		this.renderTableHeader();
		this.collection.each(this.renderUpdate, this);
		// add a button to save and log in, make a click event
		// send direction, station_id, time
	},
	renderUpdate: function(update) {
		var updateListing = new App.Views.UpdateListingView({ model: update });
		this.$("table tbody").append(updateListing.$el.children());
		this.renderSave();
	},
	renderTableHeader: function() {
		this.$('#station-table-header').text("Arrivals for " + App.stations.where({stop_id: this.station})[0].get("stop_name") + " going " + this.direction.charAt(0).toUpperCase() + this.direction.slice(1))
	},
	renderSave: function() {
		if (this.user) {
			var saveDiv = $('<div>').attr('id', 'userSave').text('Click to save!')
			this.$("table").append(saveDiv)
		} else {
			var loginDiv = $('<div>').attr('id', 'loginDiv').text('Login to Save Alert!')
			var createUserDiv = $('<div>').attr('id', 'createUserDiv').text('Create an Account!')
			this.$("table").append(loginDiv);
			this.$("table").append(createUserDiv);
		}
	},
	showLoginModal: function() {
		// draw up the modals!  then the write the functions!
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest',
		'click .loginDiv': 'showLoginModal',
		'click .createUserDiv': 'showNewUserModal'
	},
	chooseStation: function(event) {
		this.station = event.target.value
		$('#direction').removeAttr('hidden');
	},
	sendRequest: function(event) {
		this.$(".update-listing").remove()
		this.direction = event.target.id
		this.collection.fetchStationUpdates(this.station, this.direction);
	}

});