#!/bin/bash


# Pull the repo and act on the boolean value created by grep
git -C /home/capstone/HelpDesk fetch
if git -C /home/capstone/HelpDesk pull | grep -Fxq 'Already up-to-date.'
  then
      date +"[%Y %b %d %T] Already up-to-date."
  else
    # Build bianary
    dotnet publish /home/capstone/HelpDesk/src &&
    # move to working dir
    sudo cp -rf /home/capstone/HelpDesk/src/bin/Debug/netcoreapp2.0/publish/* /var/aspnetcore/HelpDesk/ &&
    # restart service
    sudo systemctl restart HelpDesk-Ticket-Service &&
   # Logging
	date +"[%Y %b %d %T] Redeploy Finished"
fi

