taki
====


## Instration
git clone git@github.com:nanapi/taki.git

## Local Setup
- ruby 2.0.0-p247
- mysql, postgresql

```sql
mysql> create database taki;
mysql> create database taki_test;
mysql> create database taki_development;
```

```sh
cd taki
bundle install
rails g devise:install
rails g devise admin_user
rake db:migrate RAILS_ENV=development
```

```sh
rails c
```

```ruby
AdminUser.create(:email => "admin@test.com", :password => "hogehoge", :password_confirmation => "hogehoge")
```

```sh
rails s
```
