# Documentation
A simple docker-compose file to run a mongodb database in docker with replica set on.
## How to run mongodb with replicaset in docker:
You will need to install [docker]('https://www.docker.com/products/docker-desktop') and [docker-compose]('https://docs.docker.com/compose/install/')

```zsh
git clone https://github.com/javilobo8/mongors.git

cd mongors
```
Before running the containers you can add the `.env` file where you can:
- Change de default configuration with this variables:
  - `$RS` -> The replicas set name (Default: rs0)
  - `$HOST` -> The replica set host (Default: 127.0.0.1)
  - `$PORT` -> The replica set port (Default: 27017)

If you want to use the default configuration just run:
```zsh
cp .env.example .env
```

Once you have all the env variables configured you can run the containers with:
```zsh
docker-compose up -d

# You can see what the script is doing by running:
docker-compose logs -f
```
The first time you run the container you have to wait a few seconds and then run the following command to initialize the replica set:
```zsh
docker exec rs0 /scripts/rs-init.sh
```
(This only has to be done the first time you run the container)

## If you want to reset your database:
```zsh
# Stop the container
docker-compose stop

# Delete the folder with the database information
rm -r data

# Rerun the container
docker-compose restart
```
