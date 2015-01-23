App.Collections.Stations = Backbone.Collection.extend({
  model: App.Models.Station,
  url: '/stations',
  fetchByLineName: function(line) {
  	this.fetch({
  		url: this.url + '/filter_by_line',
  		data: { line: line },
  		reset: true
  	});
  }, 
  initialize: function() {
    console.log('New Station Collection');
  }
});