## Disposable workspace
A short-lived Linux sandbox you don’t mind losing.

### Build the image
```bash
docker build -f disposable-workspace/custom-debian.dockerfile -t custom-deb disposable-workspace
```

### Start the container and mount current dir
```bash
docker run -it --rm -w '/work/' -v `PWD`:'/work/' custom-deb:latest zsh
```
