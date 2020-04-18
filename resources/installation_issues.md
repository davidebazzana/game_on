# Installation issues

Both of these issues occur while executing `bundle install`

### Nokogiri Issue

##### Error message:
```
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

An error occurred while installing nokogiri (1.10.9), and Bundler cannot continue.
Make sure that `gem install nokogiri -v '1.10.9' --source 'https://rubygems.org/'` succeeds before bundling.
```

##### Solution:
```
sudo apt-get install ruby-dev
sudo apt-get install zlib1g-dev
```

### Sqlite3 Issue

##### Error message:
```
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

An error occurred while installing sqlite3 (1.4.2), and Bundler cannot continue.
Make sure that `gem install sqlite3 -v '1.4.2' --source 'https://rubygems.org/'` succeeds before bundling.
```

##### Solution:
```
sudo apt-get install libsqlite3-dev
sudo gem install sqlite3 -v '1.4.2' --source 'https://rubygems.org/'
```
