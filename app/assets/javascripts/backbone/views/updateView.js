App.Views.UpdateView = Backbone.View.extend({
	el: '#station-list-view',
	station: undefined,
	direction: undefined,
	initialize: function() {
		console.log("fillling it up the drop down");
		this.listenTo(this.collection, 'reset', this.renderUpdates);
	},
	renderUpdates: function() {
		this.renderTableHeader();
		this.collection.each(this.renderUpdate, this);
		$('#floatingBarsG').toggle('hidden');
		$('table').removeAttr('hidden');
		$('#save-alert').removeAttr('hidden');
	},
	renderUpdate: function(update) {
		var updateListing = new App.Views.UpdateListingView({ model: update });
		this.$("table tbody").append(updateListing.$el.children());
	},
	renderTableHeader: function() {
		this.$('#station-table-header').text(
			"Arrivals for " + App.stations.where({stop_id: this.station})[0].get("stop_name") + " going " + this.direction.charAt(0).toUpperCase() + this.direction.slice(1))
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest',
		'click #save-alert-click': 'saveAlert',
		'click #exit-modal': 'exitModal'
	},
	chooseStation: function(event) {
		if (event !== undefined) {this.station = event.target.value};
		$('.station-name.clicked').toggleClass('clicked');
		$(event.target).toggleClass('clicked');
		$("#choose-direction").remove();
		$("<h2 id='choose-direction'>3. Choose Direction</h2>").insertAfter("h2:last")
		$('#direction').removeAttr('hidden');
		App.router.navigate([
			App.stationDropDownView.line,
			this.station
			].join('/')
		)
	},
	sendRequest: function(event) {
		if (event !== undefined) {
			this.direction = event.target.id;
			$(event.target).toggleClass('clicked');
		}
		this.$(".update-listing").remove();
		$('.direction-choice.clicked').toggleClass('clicked');
		this.collection.fetchStationUpdates(this.station, this.direction);
		$('modal').removeAttr('hidden');
		$('#floatingBarsG').toggle('hidden');
		App.router.navigate([
			App.stationDropDownView.line,
			this.station,
			this.direction
		].join('/'));
	},
	exitModal: function() {
		$('modal').toggle('hidden');
		$('#floatingBarsG').toggle('hidden');
		$('table').toggle('hidden');
		$('#save-alert').toggle('hidden');
	},
	saveAlert: function() {
		var stop = App.stations.findWhere({stop_id: this.station}).id;
		var email_address = $('input[type=text]').val();
		var time = $('input[type=time]').val();
		var newAlert = {
			email_address: email_address,
			stop: stop,
			time: time,
			direction: this.direction
		};
		$.ajax({
		  type: "POST",
		  url: '/alerts',
		  data: newAlert,
		  success: function(data) {
		  	alert("Saved!");
		  	exitModal();
		  },
		  error: function(data) {
		  	alert("fail");
		  	// write an alert with a better fail using data.responseText
		  }
		})
	}
});