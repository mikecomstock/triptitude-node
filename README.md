Installation
============

See [how to install node and
npm](https://gist.github.com/isaacs/579814)

This version works great:

    # install node wherever.
    # use sudo even, it doesn't matter
    # we're telling npm to install in a different place.

    echo prefix = ~/local >> ~/.npmrc
    curl https://npmjs.org/install.sh | sh

Install dependencies:

    npm install -g supervisor coffee-script bower
    bower install

You should now be able to run the app with:

    npm start
