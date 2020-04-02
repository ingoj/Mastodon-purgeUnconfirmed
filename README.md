# Mastodon-purgeUnconfirmed
This script purges unconfirmed accounts on your Mastodon instance after 2 weeks.

# Installation
Drop this script within your user that runs your Mastodon instance, usually `mastodon`, e.g. in `/home/mastodon/bin` and make it executable, e.g. `chmod u+rx /home/mastodon/bin/purgeUnconfirmed.sh`

Depending on your setup you also might want to use a PostgreSQL password file in `/home/mastodon/.pgpass` and add your credentials to access the database. 

Also don't forget to add a crontab entry, e.g.: 

`15 3    * * 1   cd /home/mastodon/live && /home/mastodon/bin/purgeUnconfirmed.sh > /dev/null`
