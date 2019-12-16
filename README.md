# README

## DB setup

### Dev

```
CREATE DATABASE trumped_development;
CREATE USER trumped_development WITH PASSWORD 'password';
ALTER USER trumped_development WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE "trumped_development" to trumped_development;
```

### Test

```
CREATE DATABASE trumped_test;
CREATE USER trumped_test WITH PASSWORD 'password';
ALTER USER trumped_test WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE "trumped_test" to trumped_test;
```

### db restarting

bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:create RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
