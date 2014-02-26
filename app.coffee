express = require 'express'

app = express()
pub = __dirname + '/public'

app.use app.router
app.use express.static pub
app.use express.errorHandler()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.get '/', (req,res) ->
	res.render 'main',
		scripts : ['bower_components/angular/angular.js','lib/main.js']

app.listen 3000