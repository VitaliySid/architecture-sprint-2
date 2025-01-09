#!/bin/bash

docker compose exec -T shard1_1 mongosh --port 27011 --quiet  <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF

docker compose exec -T shard2_1 mongosh --port 27021 --quiet  <<EOF
use somedb
db.helloDoc.countDocuments()
exit();
EOF