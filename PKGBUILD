# Maintainer: JustKidding <jk@vin.ovh>
# Maintainer: asakura42
# Contributors: WSDMatty, Crotok, SantoZ, Det, Achilleas Pipinellis, speed145a, Schnouki

pkgname=ungoogled-chromium-bin
pkgver=87.0.4280.88
pkgrel=3
pkgdesc="A lightweight approach to removing Google web service dependency (binary version)"
arch=("x86_64")
url="https://ungoogled-software.github.io/"
license=("BSD")
provides=("chromium")
conflicts=("chromium" "iridium" "ungoogled-chromium")
depends=('gtk3' 'nss' 'alsa-lib' 'xdg-utils' 'libxss' 'libcups' 'libgcrypt'
         'ttf-font' 'systemd' 'dbus' 'libpulse' 'pciutils' 'json-glib' 'libva'
         'desktop-file-utils' 'hicolor-icon-theme' 'jsoncpp' 'openjpeg2' 're2'
         'snappy' 'minizip' 'libxslt')
optdepends=('pepper-flash: support for Flash content'
            'pipewire: WebRTC desktop sharing under Wayland'
            'kdialog: needed for file dialogs in KDE'
            'gnome-keyring: for storing passwords in GNOME keyring'
            'kwallet: for storing passwords in KWallet'
            'libva-intel-driver: for hardware video acceleration with Intel GPUs'
            'libva-mesa-driver: for hardware video acceleration with AMD/ATI GPUs'
            'libva-vdpau-driver: for hardware video acceleration with NVIDIA GPUs')

source=("https://download.opensuse.org/repositories/home:/justkidding:/arch/standard/x86_64/ungoogled-chromium-$pkgver-$pkgrel-x86_64.pkg.tar.zst")
sha256sums=("1220af284e9214b6971fdf8ecfeb8aa70f1a9c99331353e23e99aa2899cfcea8")

package() {
  cp -R "${srcdir}/usr/" "${pkgdir}/usr"
  chown root $pkgdir/usr/lib/chromium/chrome-sandbox
  chmod 4755 $pkgdir/usr/lib/chromium/chrome-sandbox
}
