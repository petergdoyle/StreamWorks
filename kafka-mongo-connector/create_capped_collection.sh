#!/bin/sh

use estreaming
db.createCollection("splash",{ capped : true, size : 5242880, max : 5000 } )
