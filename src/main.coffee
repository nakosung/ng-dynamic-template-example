angular.module('test', [])
	.directive 'dynamicTemplate', ($compile) ->
		restrict : 'E'
		scope : template : '&'
		compile : (elem,attrs) ->
			(scope,element,attrs) ->
				cur = undefined
				remove = undefined
				bye_watch = scope.$watch ->
					# evaluate 'template'
					template = scope.template()	

					# only if when it changes
					return if template == cur

					# cache 'template' to compare later with
					cur = template 

					# cleanup old one
					remove?()

					# setup raw-html
					element.html template 

					# prepare new scope for new template
					new_scope = scope.$new() 
					
					# this is the clean up function
					remove = -> new_scope.$destroy()

					# link them up
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


