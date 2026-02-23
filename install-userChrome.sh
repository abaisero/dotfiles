#!/bin/bash

source ./shell-utils

echo_info By default, userChrome.css modifications are disabled in Firefox. You need to make sure that on the about:config page in Firefox, the toolkit.legacyUserProfileCustomizations.stylesheets preference is set to true and then restart the browser.

FIREFOX_DIR="$HOME/snap/firefox/common/.mozilla/firefox"
test -d "$FIREFOX_DIR" || { echo_error "This script is meant to be used with the snap version of Firefox. '$FIREFOX_DIR' not found. Exiting."; exit 1; }

for PROFILE_DIR in $(find "$FIREFOX_DIR" -type d -name "*.default" -print); do
  TARGET="$PROFILE_DIR/chrome/userChrome.css"
  mkdir -p "$(dirname "$TARGET")"
  ln -s --backup=numbered "$(realpath firefox.userChrome.css)" "$TARGET"
done
