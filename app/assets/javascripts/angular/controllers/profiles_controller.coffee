angular.module('kopool').controller('ProfilesCtrl', ['$scope', 'currentUser', '$http', ($scope, currentUser, $http) ->
	console.log('in kopool ProfilesCtrl')

	$scope.loadUserData = ->
		console.log("Called loadUserData in profiles_controller.coffee")
		$http.get('users/edit.json').success(response) ->
			$scope.existing_user = response.data 

	$scope.loadUserData()


]);