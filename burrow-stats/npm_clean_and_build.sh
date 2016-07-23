#!/bin/sh
cd $(dirname $0)

# npm install babel-core babel-loader --save-dev

export NODE_ENV='production'

npm install
npm run build
