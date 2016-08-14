use estreaming;
var t = db.splash;
var cursor = t.find().addOption(DBQuery.Option.tailable). addOption(DBQuery.Option.awaitData)
while (cursor.hasNext()) { print(tojson(cursor.next())); }
