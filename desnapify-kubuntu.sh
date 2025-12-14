sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
sudo snap remove --purge firefox
sudo snap remove --purge thunderbird
sudo snap remove --purge gnome-42-2204
sudo snap remove --purge gtk-common-themes
sudo snap remove --purge gtk-theme-breeze
sudo snap remove --purge icon-theme-breeze
sudo snap remove --purge bare
sudo snap remove --purge core20
sudo snap remove --purge snapd
sudo apt autopurge snapd -y
echo '# To prevent repository packages from triggering the installation of snap,
# this file forbids snapd from being installed by APT.
Package: snapd
Pin: release a=*
Pin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozilla
sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: thunderbird*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozillateamppa
sudo apt update && sudo apt install firefox firefox-l10n-* thunderbird thunderbird-l10n-* -y

