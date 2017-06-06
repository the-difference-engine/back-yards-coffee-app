# Back of the Yards Coffee

Back of the Yards Coffee Co. is a specialty coffee roaster located in Chicago's Back of the Yards community that not only produces great tasting coffee, but that also makes a direct social and economic impact in the community

## Application details:

* Ruby version: _____
* Rails version: 5.0.3
* This is a Postgres database

## Installing

* `git clone https://github.com/the-difference-engine/back-yards-coffee-app.git`
* `bundle install`
* `rake db:create`
* `rake db:migrate`
* `rspec`
* `rails s`

## Deployment instructions:

* QA Server (DEV): `git push demo demo:master` branch is continuously deployed using Codeship
* Demo Server (STAGING): `git push demo demo:master`
* Prod Server (PRODUCTION): `git push prod master`