App.Routers.Router = Backbone.Router.extend({

	initialize: function() {
		App.stations = new App.Collections.Stations();
		App.stationDropDownView = new App.Views.StationDropDownView({
			collection: App.stations
		});
		App.updates = new App.Collections.Updates();
		App.updatesView = new App.Views.UpdateView({
			collection: App.updates 
		}); 
	},
	
	routes: {
		'': 														'index',
		':line': 												'line',
		':line/:stationID': 						'station',
		':line/:stationID/:direction':  'direction'
	},

	line: function(line) {
		App.stationDropDownView.line = line;
		App.stationDropDownView.chooseLine();
	},

	station: function(line, stationID) {
		this.line(line);
		setTimeout(function() {
			$('.clicked').removeClass('clicked');
			var station = $( '.station-name[value=' + stationID + ']' )
			station.addClass('clicked');
			$('#direction').toggle('hidden');
		}, 65);
	},

	direction: function(line, stationID, direction) {
		this.station(line, stationID);
		setTimeout(function() {
			$('.direction-choice').removeClass('clicked');
			App.updatesView.direction = direction;
			App.updatesView.station = stationID;
			App.updatesView.sendRequest();
		}, 80);
	}

})
