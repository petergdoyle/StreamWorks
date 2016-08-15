use estreaming;
var cursor = db.splash.find().addOption(DBQuery.Option.tailable). addOption(DBQuery.Option.awaitData)
while (cursor.hasNext()) { print(tojson(cursor.next())); }
