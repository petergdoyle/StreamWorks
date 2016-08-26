var conn = new Mongo();
db = conn.getDB("estreaming");
db.createCollection( "splash", { capped: true, max: 5000 } );
