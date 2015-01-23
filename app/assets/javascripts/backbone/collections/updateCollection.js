App.Collections.Updates = Backbone.Collection.extend({
  model: App.Models.Update,
  url: '/stations/',
  fetchStationUpdates: function(id, direction) {
    debugger
  	this.fetch({
  		url: this.url + id + '/updates',
  		data: {direction: direction},
  		reset: true
  	});
  },
  initialize: function() {
    console.log('New Station Collection');
  }
});  