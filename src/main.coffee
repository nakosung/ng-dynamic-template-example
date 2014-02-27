"use strict"
angular.module('test', [])
	.controller 'MainCtrl', ($scope,$templateCache) ->
		$scope.index = 1
		$scope.templates = 
			1 : '<div ng-controller="X"><div>changed -> 1 {{value}}</div><button class="btn btn-primary">Test</button></div>'
			2 : '<div ng-controller="Y">NUMBER 2 - changed -> 2 {{value}}</div>'
			3 : '<div>pending</div>'
		$scope.sel = (x) ->
			$scope.index = x
		$scope.$watch 'index', (x) ->
			path = "/$dynamichtml/#{x}.html"
			$templateCache.put path, $scope.templates[x]
			$scope.path = path
	.controller 'X', ($scope) ->
		$scope.value = 'this is X'
		$scope.$on '$destroy', ->
			console.log 'X was properly destroyed'
	.controller 'Y', ($scope) ->
		$scope.value = 'this is Y'
		$scope.$on '$destroy', ->
			console.log 'Y was properly destroyed'


