#!/bin/bash
temp=$(mktemp)
version=$(curl -sL "https://download.opensuse.org/repositories/home:/justkidding:/arch/standard/x86_64/" | sed 's/<[^>]*>//g'| grep -o "ungoogled-chromium-[[:digit:]].*-x86_64.pkg.tar.zst")
download=$(curl -sL "https://download.opensuse.org/repositories/home:/justkidding:/arch/standard/x86_64/$version.mirrorlist" | grep -m1 "http.*87.0.4280.88" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u)
curl -L "$download" -o "$temp"
shasum=$(sha256sum "$temp" | cut -d' ' -f1)
pkgver="$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" <<< "$version")"
pkgrel="$(grep -o "\-[[:digit:]]*\-" <<< "$version" | sed 's/-//g')"
sed -i "s/^pkgver=.*/pkgver=$pkgver/" PKGBUILD
sed -i "s/^pkgrel=.*/pkgrel=$pkgrel/" PKGBUILD
sed -i "s/^sha256sums=.*/sha256sums=(\"$shasum\")/" PKGBUILD
git commit . -m "bump version: $pkgver"
