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
  cp -R /data/data/com.termux/files/home/storage/downloads/ssh/. ~/.ssh/
fi

if [[ -d /data/data/com.termux/files/home/storage/downloads/src ]]; then
  if [[ ! -e "~/src" ]]; then
    ln -s /data/data/com.termux/files/home/storage/downloads/src ~/src
  fi
fi

# alrighty, let's sort out our dotfiles
git clone https://github.com/grahamgilbert/termux-dotfiles.git "$TMPDIR/termux-dotfiles"

for f in $TMPDIR/termux-dotfiles/*
do
  filename=$(basename "$f")
  if [ "$filename" != "README.md" ]; then
    cp -f $f "~/.${filename}"
  fi
done

rm -rf $TMPDIR/termux-dotfiles
source ~/.bashrc
