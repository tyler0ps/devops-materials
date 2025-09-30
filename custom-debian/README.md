docker build -f custom-debian/custom-debian.dockerfile -t tyler-deb custom-debian
docker run -it --rm -w '/work/' -v `PWD`:'/work/' tyler-deb:latest zsh