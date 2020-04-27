# README

## Installation

#### Ruby version: 2.5.5

#### Configuration
Run `bundle install --path vendor/cache/` to install the needed gems.

#### Database initialization 
Run `rake db:drop && rake db:migrate` to apply the migrations to the database.

## Common Issues

#### Installing sassc
While running `bundle install --path vendor/cache/`.
If the error message refers to a Makefile, such as:
```
make: g++: Command not found
make: *** [Makefile:235: SharedPtr.o] Error 127

make failed, exit code 2
```
install `apt-get install gcc` and `apt-get install build-essential`.
