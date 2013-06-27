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

There are a number of profiles defined in the cucumber.yml file 

* mac-safari 
* mac-firefox
* mac-chrome 
* win7-ie
* win7-firefox
* win7-chrome
* win-vista-ie
* win-vista-firefox
* win-vista-chrome
* win8-ie
* win8-firefox
* win8-chrome
* win-vista-ie
* win-vista-firefox
* win-vista-chrome

There are also command line options to choose the target device and target server

* SERVER = INTEGRATION, QA, STAGING, PRODUCTION
* DEVICE = MOBILE, TABLET-PORTRAIT, TABLET-LANDSCAPE, DESKTOP (resizes the browser window to suit target device)

e.g. to test Firefox on Windows 7, on the QA server, simulating a tablet in landscape :

```
cucumber -p win7-firefox SERVER=QA DEVICE=TABLET-LANDSCAPE
```


