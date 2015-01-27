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
		this.$(".update-listing").remove();
		this.$("#loginDiv").remove();
		this.$("#createUserDiv").remove();
		this.$("table").removeAttr('hidden');
		this.renderTableHeader();
		this.collection.each(this.renderUpdate, this);
		this.renderSave();
		// add a button to save and log in, make a click event
		// send direction, station_id, time
	},
	renderUpdate: function(update) {
		var updateListing = new App.Views.UpdateListingView({ model: update });
		this.$("table tbody").append(updateListing.$el.children());
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
		this.$('#login-form').empty();
		this.$('#create-user').empty();
		var loginForm = $("<form>");
		loginForm.append($('<input type="text" name="username" placeholder="Username" >'));
		loginForm.append($('<input type="password" name="password" placeholder="Password" >'));
		loginForm.append($('<input type="submit" value="Submit">'));
		this.$('#login-form').append(loginForm);
		this.$("modal").removeAttr('hidden');
	},
	showNewUserModal: function() {
		this.$('#login-form').empty();
		this.$('#create-user').empty();
		var createUserForm = $("<form>");
		createUserForm.append($('<input type="text" name="username" placeholder="Username" >'));
		createUserForm.append($('<input type="password" name="password" placeholder="Password" >'));
		createUserForm.append($('<input type="password" name="confirm-password" placeholder="Confirm Password" >'));
		createUserForm.append($('<input type="text" name="confirm-email" placeholder="email" >'));
		createUserForm.append($('<input type="submit" value="Submit">'));
		this.$('#create-user').append(createUserForm);
		this.$("modal").removeAttr('hidden');
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest',
		'click #loginDiv': 'showLoginModal',
		'click #createUserDiv': 'showNewUserModal',
		'click #create-user :submit': 'saveNewUser',
		'click #login-form :submit': 'loginUser'
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
	saveNewUser: function() {
		debugger
		var userName = $($('#create-user input')[0]).val();
		var password = $($('#create-user input')[1]).val();
		var passwordConfirmation = $($('#create-user input')[2]).val()
		var emailAddress = $($('#create-user input')[3]).val();
		var newUser = { data: {
			username: userName,
			password: password,
			password_confirmation: passwordConfirmation,
			email_address: emailAddress
			}
		};
		$.ajax({
			type: 'POST',
			url: '/users',
			data: newUser,
			success: function(data) {

			}
		})
	}

});