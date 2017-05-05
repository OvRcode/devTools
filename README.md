# Development Repo for OvRride
OvRride Docker developement/production setup. Running this in production will require a separate docker file for overriding key variables.

##Urls:
- ovrride.dev
- rockawaybeachbus.dev

## Dependencies
- [Docker](https://www.docker.com/)
- [S3cmd](http://s3tools.org/s3cmd)

## Important Links
- [Trusting self signed certs on os x](https://www.accuweaver.com/2014/09/19/make-chrome-accept-a-self-signed-certificate-on-osx/)  
- Dnsmasq Setup [install guide here](https://passingcuriosity.com/2013/dnsmasq-dev-osx/)

# Setup
- The following environmental variables need to be set to run:
  - `OVRGIT`
    - The location of the main ovrride git repo
  - `LISTSGIT`
    - The location of the lists repo
  - `RBBGIT`
    - rockawaybeachbus repo location
  - `AWS_ACCESS_KEY_ID`
    - AWS access key for s3cmd to download pics and db backups
  - `AWS_SECRET_ACCESS_KEY`
    - AWS secret key for s3cmd to download pics and db backups
- On a linux system /etc/environment seems to be the best place to set these

# After updating WordPress version in code container the following steps need to be taken
  - `docker-compose build ovr_code`
  - `docker-compose stop ovr_hhvm ovr_web`
  - `docker-compose rm -f ovr_web ovr_hhvm ovr_code`
  - `docker-compose up -d`
