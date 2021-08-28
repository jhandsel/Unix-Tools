## Install Docker on mac
Install app and dependencies
```
brew install --cask docker virtualbox 
brew install docker-machine
```

Create virtualbox driver
```
docker-machine create --driver virtualbox default
docker-machine restart
```

Check machine environment (this will give the IP of the virtualbox docker is in)
```
docker-machine env
```

Set up shell environment
```
eval "$(docker-machine env default)" 
```
(This might throw an TSI connection error. In that case run docker-machine regenerate-certs default)

Test the installation
```
docker run hello-world
```

Stop the daemon when done
```
docker-machine stop
```

## Using Docker on mac
Start the daemon
```
docker-machine start
```
Wait for it to start the virtual box and get an IP, then use as normal.
