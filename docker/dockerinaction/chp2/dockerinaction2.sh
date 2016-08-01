CLIENT_ID="portia"

if [ ! -n "$CLIENT_ID" ]; then
  echo "Client ID not set"
  exit 1
fi


DB_CID=$(docker create -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5)
docker start $DB_CID

until [ "$(docker inspect -f {{.State.Running}} $DB_CID)" == "true" ]; do
  sleep 0.1;
done;

MAILER_CID=$(docker create dockerinaction/ch2_mailer)
docker start $MAILER_CID

until [ "$(docker inspect -f {{.State.Running}} $MAILER_CID)" == "true" ]; do
    sleep 0.1;
done;

WP_CID=$(docker create \
  --link $DB_CID:mysql \
  --name wp_$CLIENT_ID \
  -p 80 \
  -v /run/lock/apache2/ \
  -v /run/apache2/ \
  -e WORDPRESS_DB_NAME=$CLIENT_ID \
  --read-only wordpress:3)

docker start $WP_CID

until [ "$(docker inspect -f {{.State.Running}} $WP_CID)" == "true" ]; do
    sleep 0.1;
done;

AGENT_CID=$(docker create \
  --name agent_$CLIENT_ID \
  --link $WP_CID:insideweb \
  --link $MAILER_CID:insidemailer \
  dockerinaction/ch2_agent)

docker start $AGENT_CID

until [ "$(docker inspect -f {{.State.Running}} $AGENT_CID)" == "true" ]; do
    sleep 0.1;
done;
