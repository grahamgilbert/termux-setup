#!/data/data/com.termux/files/usr/bin/bash
# Get a Termux environment set up quickly

# Get the storage set up
termux-setup-storage

# Install some packages
pkg install -y nano git openssh python python-dev python2 coreutils proot

# Copy in your ssh keys
if [[ ! -d /data/data/com.termux/files/home/storage/downloads/ssh ]]; then
  echo "SSH key directory not present"
else
  cp -R /data/data/com.termux/files/home/storage/downloads/ssh ~/.ssh
fi

if [[ -d /data/data/com.termux/files/home/storage/downloads/src ]]; then
  ln -s /data/data/com.termux/files/home/storage/downloads/src ~/src
fi

if [[ -f "~/.bashrc" ]]; then
  rm -f ~/.bashrc.bak
  mv "~/.bashrc" ~/.bashrc.bak
fi

echo "alias ipaddress=\"ifconfig arc0 | awk '/inet /{print $2}'\"" >> ~/.bashrc
termux-chroot
sshd