#!/bin/bash
# In case any of this variables does not exist set a default value
[ -z $RS ] && RS=rs0
[ -z $HOST ] && HOST=127.0.0.1
[ -z $PORT ] && PORT=27017

mongosh <<EOF
var config = {
  _id : "$RS",
  version: 1,
  members: [
    { _id: 0, host: "$RS:$PORT" }
  ]
};
rs.initiate(config, { force: true });
rs.status();
EOF