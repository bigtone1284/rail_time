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
			this.$('#login-form').empty();
			this.$('#create-user').empty();
			var timeInput = $('<input type="time" name="alert_time">')
			var saveDiv = $('<div>').attr('id', 'userSave').text('Click to save!')
			this.$("table").append(timeInput).append(saveDiv)
		} else {
			var loginDiv = $('<div>').attr('id', 'loginDiv').text('Login to Save Alert!')
			var createUserDiv = $('<div>').attr('id', 'createUserDiv').text('Create an Account!')
			this.$("table").append(loginDiv);
			this.$("table").append(createUserDiv);
		}
	},
	showLoginModal: function() {
		this.$("#loginDiv").empty();
		this.$("#createUserDiv").empty();
		this.$('#login-form').empty();
		this.$('#create-user').empty();
		var loginForm = $("<form>");
		loginForm.append($('<input type="text" name="username" placeholder="Username" >'));
		loginForm.append($('<input type="password" name="password" placeholder="Password" >'));
		loginForm.append($('<input type="button" value="Submit">'));
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
		createUserForm.append($('<input type="button" value="Submit">'));
		this.$('#create-user').append(createUserForm);
		this.$("modal").removeAttr('hidden');
	},
	events: {
		'click .station-name': 'chooseStation',
		'click .direction-choice': 'sendRequest',
		'click #loginDiv': 'showLoginModal',
		'click #createUserDiv': 'showNewUserModal',
		'click #create-user :button': 'saveNewUser',
		'click #login-form :button': 'loginUser',
		'click #userSave': 'saveAlert'
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
				alert('New Profile Successfully made!');
				App.updatesView.showLoginModal();
			},
			error: function(data) {
				//use return errors to make a better alert.
				alert('Error! -- Please Try Again!');
				App.updatesView.showNewUserModal();
			}
		})
	},
	loginUser: function() {
		var userName = $($('#login-form input')[0]).val();
		var password = $($('#login-form input')[1]).val();
		var loginInfo = { data: {
			username: userName,
			password: password
			}
		};
		$.ajax({
			type: 'POST',
			url: '/sessions',
			data: loginInfo,
			success: function(data) {
				alert('Login Succesful');
				App.updatesView.user = data.id
				App.updatesView.renderSave()
			},
			error: function(data) {
				alert('Login Failed -- Please Try Again.')
				App.updatesView.showLoginModal();
			}

		})
	},
	saveAlert: function() {
		var station = App.stations.where({stop_id: this.station})[0].get("id");
		var direction = this.direction;
		var user = this.user;
		var time = $('input').val();
		var alert = { data : {
			station: station,
			direction: direction,
			user: user,
			time: time
			}
		};
		$.ajax({
			type: 'POST',
			url: '/alerts',
			data: alert,
			success: function(data) {
				alert('Alert Saved!');
				$('input')[0].remove()
				$('#userSave').remove()
			},
			error: function(data) {
				alert('Alert not saved!');
			}
		})
	}
});