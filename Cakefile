{exec} = require 'child_process'
task 'sbuild', 'build', ->
	exec "coffee -c -o public/lib/ src/", (err,stdout,stderr) ->
		console.log err, stdout, stderr