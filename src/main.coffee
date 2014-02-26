angular.module('test', [])
	.directive 'dynamicTemplate', ($compile) ->
		restrict : 'E'
		scope : template : '&'
		compile : (elem,attrs) ->
			(scope,element,attrs) ->
				cur = undefined
				remove = undefined
				bye_watch = scope.$watch ->
					template = scope.template()							
					
					return if template == cur

					cur = template

					remove?()

					element.html template

					new_scope = scope.$new()

					remove = -> new_scope.$destroy()

					$compile(element.contents()) new_scope
					
				scope.$on '$destroy', ->
					bye_watch()
					remove?()

	.controller 'MainCtrl', ($scope) ->
		$scope.index = 1
		$scope.templates = 
			1 : '<div ng-controller="X"><div>changed -> 1 {{value}}</div><button class="btn btn-primary">Test</button></div>'
			2 : '<div ng-controller="Y">NUMBER 2 - changed -> 2 {{value}}</div>'
			3 : '<div>pending</div>'
		$scope.sel = (x) ->
			$scope.index = x
	.controller 'X', ($scope) ->
		$scope.value = 'this is X'
		$scope.$on '$destroy', ->
			console.log 'X was properly destroyed'
	.controller 'Y', ($scope) ->
		$scope.value = 'this is Y'
		$scope.$on '$destroy', ->
			console.log 'Y was properly destroyed'


