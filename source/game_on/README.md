# README

## Installation
Ruby version: 2.5.5.\
To run the application, the antivirus [ClamAV](https://www.clamav.net/) has to be running in background. Make sure clamav-daemon is started by running the command 
`service clamav-daemon status`.\
### Configuration
Run `bundle install --path vendor/cache/` to install the needed gems.\
There's a file that needs to be written and put inside the `config` folder. It has to be named `application.yml` and it has to be structured like this:
```
MAIL_USERNAME: "<the website's mail>"
MAIL_PASSWORD: "<the website's mail password>"

GOOGLE_OAUTH2_API_KEY: "<a valid googleOAuth2 api key>"
GOOGLE_OAUTH2_API_SECRET: "<a valid googleOAuth2 api secret>"

GITHUB_API_KEY: "<a valid github oauth api key>"
GITHUB_API_SECRET: "<a valid github oauth api secret>"

TYPINGDNA_API_KEY: "<a valid typingDNA api key>"
TYPINGDNA_API_SECRET: "<a valide typingDNA api secret>"

KEY: "<a 32 bytes random generated key in console using the command SecureRandom.random_bytes(32)>"
```
Then you can run the application with the command `rails s`


### Database initialization 
Run `rake db:drop && rake db:migrate` to apply the migrations to the database.

## Common Issues
When uploading a game it's possible that the process could exceed the timeout. Don't worry, the game has been uploaded.
### Installing sassc
While running `bundle install --path vendor/cache/`.
If the error message refers to a Makefile, such as:
```
make: g++: Command not found
make: *** [Makefile:235: SharedPtr.o] Error 127

make failed, exit code 2
```
install `apt-get install gcc` and `apt-get install build-essential`.
