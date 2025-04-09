#!/bin/sh

set -ue

DEFAULT_GROUPS='wheel'
DEFAULT_UID='1000'

echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

if getent passwd "$DEFAULT_UID" > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

while true; do

  # Prompt from the username
  read -p 'Enter new UNIX username: ' username

  # Create the user
  if adduser -u 1000 "$username" -G "$DEFAULT_GROUPS"; then
    # Add newly created user to sudoers.d
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers.d/$username"
    break
  fi
done
