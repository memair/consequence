# README

## DB setup

### Dev

```
CREATE DATABASE consequence_development;
CREATE USER consequence_development WITH PASSWORD 'password';
ALTER USER consequence_development WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE "consequence_development" to consequence_development;
```

### Test

```
CREATE DATABASE consequence_test;
CREATE USER consequence_test WITH PASSWORD 'password';
ALTER USER consequence_test WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE "consequence_test" to consequence_test;
```

### db restarting

bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:create RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
