# Docker

## New to Docker?
If you are completely new to Docker, please see the [Getting Started with Docker Guide](https://docs.docker.com/get-started/) on Docker's official website. Your first exposure to using containers can be confusing, so please  don't hesitate to ask your team's Technical Lead for help.

## Install Docker
Select the installation guide below for your laptop's operating system:
- [**Mac OSX**](https://docs.docker.com/docker-for-mac/install/)
- [**Linux**](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#set-up-the-repository)
- [**Windows**](https://docs.docker.com/docker-for-windows/install/)

## Install Docker Compose
### Mac OSX & Windows
For **Mac OSX** and **Windows** users, Docker Compose is already included with the Docker toolbox.

### Linux
For linux users, you will have to install the docker compose binary from the [Docker Compoose release repository](https://github.com/docker/compose/releases). Please follow the instructions below to properly install docker compose:

1. Run this command in your terminal to install the Docker Compose binary

```
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

2. Apply [executable permissions](https://ryanstutorials.net/linuxtutorial/permissions.php) to the binary

```
sudo chmod +x /usr/local/bin/docker-compose
```

3.) Run the following command to confirm that Docker Compose was properly installed:
```
docker-compose --version
```
You should expect the results to look similar to:
```
docker-compose version 1.17.0, build 1719ceb
```

## Building BOTY-app images
Build the docker images by running the following command:
```
docker-compose build
```
This will build your `ruby`, `postgres`, and `backyardscoffee_web` images

## Running BOTY-app containers
1. You will need an empty `Gemfile.lock` in order to build your `Dockerfile`. You can delete and create a new blank dockerfile by running the following commands in the rails app root directory:

```
rm -rf Gemfile.lock
touch Gemfile.lock
```

The following command will run your containers:
```
docker-compose up
```

### Initial container setup
If this is your first time running these containers, you will need to run the following commands to setup the database:

```
docker-compose run web rake db:create
docker-compose run web rake db:migrate
```
This will create and migrate all databases in `config/database.yml`.

Run `docker-compose up` again to run your rails app.

> Please contact your Techinical Lead(s) if you have any problems getting your docker containers set up