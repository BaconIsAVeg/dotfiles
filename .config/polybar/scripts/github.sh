#!/bin/sh

USER=$(git config --get github.user)
TOKEN=$(git config --get github.token)

notifications=$(echo "user = \"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo $notifications
else
    echo 0
fi
