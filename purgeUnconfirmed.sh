#!/bin/sh
# this script purges unconfirmed accounts (where the user did not clicked on the link in the registration mail)
# from your Mastodon instance after 2 weeks

# please change the settings in the variables accordingly:
MASTODONPATH="/home/mastodon/live"
PGSQLUSER="mastodon"
PGSQLHOST="127.0.0.1"

cd ${MASTODONPATH} || exit 0

${MASTODONPATH}/bin/tootctl cache recount accounts
${MASTODONPATH}/bin/tootctl cache recount statuses
for i in $(/usr/bin/psql -t -U ${PGSQLUSER} -h ${PGSQLHOST} mastodon -c "select username from users u, accounts a where account_id=a.id and confirmed_at is null and confirmation_sent_at<now() - interval'2 weeks';") ; do
        ${MASTODONPATH}/bin/tootctl accounts delete ${i} #2>/dev/null 1>/dev/null
done
for i in $(/usr/bin/psql -t -U ${PGSQLUSER} -h ${PGSQLHOST} mastodon -c "select username from users u, accounts a where account_id=a.id and suspended_at<now() - interval'2 weeks'") ; do
        ${MASTODONPATH}/bin/tootctl accounts delete ${i} #2>/dev/null 1>/dev/null
done