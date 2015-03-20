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
		$( '.station-name[value=' + stationID + ']' ).addClass('clicked');
	}

})