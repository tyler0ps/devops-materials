### Build the image
```bash
docker build -f custom-debian/custom-debian.dockerfile -t tyler-deb custom-debian
```

### Start the container and mount current dir
```bash
docker run -it --rm -w '/work/' -v `PWD`:'/work/' tyler-deb:latest zsh
```
