# trusterd-app-on-heroku-using-docker

## What is this

You can run trusterd http2 server on heroku using docker.

## how to use

```bash
git clone https://github.com/kjunichi/trusterd-app-on-heroku-using-docker.git
cd trusterd-app-on-heroku-using-docker/
heroku docker:start
```

## How to response in mruby

When you add mruby script( ex. hoge.rb) to htdocs folder,you can get response by accsess to /hoge.rb.

## configuration files

### conf/trusterd.conf.rb

this is trusterd configuration file.

### build_config.rb

When you add mrbgems,you can edit this file.

### Dockerfile

When you use external native libraries,you can edit this file.

## TODO

- qrintf
