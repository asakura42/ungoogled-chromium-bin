#!/bin/bash
zst=$(curl -s "https://repo.vin.ovh/arch/x86_64/" | grep ungoogled | grep -o "ungoogled.*zst" | sort -u)
links=$(echo "$zst" | sed 's|^|https://repo.vin.ovh/arch/x86_64/|')
curl -LO "$links.sig"
curl -LO "$links"
gpg --recv-keys 3DEA62513C8035383A245A12E5786B42E8E5D565
gpg "$temp/$zst.sig"
if [ $? -eq 0 ]
then
	version=$(ls -1 | grep "ungoogled-chromium.*zst$" | head -n1)
	pkgver="$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" <<< "$version")"
	pkgrel="$(grep -o "\-[[:digit:]]*\-" <<< "$version" | sed 's/-//g')"
	shasum=$(sha256sum "$temp/ungoogled-chromium-$pkgver-$pkgrel-x86_64.pkg.tar.zst" | cut -d' ' -f1)
	sed -i "s/^pkgver=.*/pkgver=$pkgver/" PKGBUILD
	sed -i "s/^pkgrel=.*/pkgrel=$pkgrel/" PKGBUILD
	sed -i "s/^sha256sums=.*/sha256sums=(\"$shasum\")/" PKGBUILD
	git commit . -m "bump version: $pkgver"
else
	echo Problem with signature.
fi
