# yc-data
Lightweight internal research data for YC companies

## Populate starter database
1. Export bookface data files as json and save to "#{Rails.root}/tmp/"
2. `rake db:drop; rake db:create; rake db:migrate; rake db:seed; rake db:seed_bookface`

## Export local database to heroku
1. `pg_dump -Fc --no-acl --no-owner -h localhost ycdata-development > mydb.dump`
2. Upload mydb.dump to S3 or other publicly accessible URL
3. `heroku pgbackups:restore DATABASE 'http://public_URL'`


## To start local SSL
thin start --ssl -p 3001