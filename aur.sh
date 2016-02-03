#!/bin/sh	

echo -n "Enter your desired AUR package: "
read pkg

aurpkgdir=/tmp/aurpkg
aurpkg="${pkg}.tar.gz"
pwd=$(pwd)

mkdir -p "$aurpkgdir" && cd "$aurpkgdir"

curl -o "$aurpkg" "https://aur.archlinux.org/cgit/aur.git/snapshot/${aurpkg}"

if [ "$?" = "0" ]; then
  tar xvf "${aurpkg}"
  cd "${pkg}"
  makepkg -si
  cd "$pwd"
else
   echo 'Package not found.  Are you sure it is in the AUR?'
   cd "$pwd"
   exit 1
fi
