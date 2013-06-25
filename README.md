# blinkbox books Website Test Suite

## Pre-Setup

Get Ruby running on your system.

### OS X Only

[Install RVM](http://octopress.org/docs/setup/rvm/) which lets you easily manage your Ruby versions.

Next make sure you've got Ruby 1.9.3 installed:

```
$ rvm install 1.9.3
```

The Ruby version to use is in the Gemfile, so when you `cd` to the root directory RVM should automatically switch to using 1.9.3. You can verify this by running:

```
$ ruby -v
```

### Windows Only

_Note: If you have any other versions of Ruby installed, it might be worth uninstalling them first just in case you run into any issues._

Download the latest Ruby 1.9.3 installer from [here](http://rubyinstaller.org/downloads/). The current 1.9.3-p429 build is [here](http://rubyforge.org/frs/download.php/76952/rubyinstaller-1.9.3-p429.exe).

Run the EXE, and choose the option to add the Ruby binaries to your PATH (plus any other options you like the look of).

## Setup

Install bundler:

```
$ gem install bundler
```

And finally install all the requirements for this suite:

```
$ bundle
```

## Running

The default option is to test locally using Firefox with target site nodejs-internal 

```
$ cucumber
```

To test via the Selenium Grid server

Target: Safari on OSX


```
$ cucumber -p integration-mac-safari
```

