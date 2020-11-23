# Docker base image with VNC    

**Try it**   
```
docker run --name vnc -v $(pwd)/apache-jmeter-5.2.1:/opt/jmeter -p 5901:5901 -it --rm rdpanek/vnc:1.0
```

**Some ideas**

https://raw.githubusercontent.com/ConSol/docker-headless-vnc-container/master/Dockerfile.ubuntu.xfce.vnc
