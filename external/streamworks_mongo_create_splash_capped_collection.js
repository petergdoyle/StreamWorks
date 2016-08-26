var conn = new Mongo();
db = conn.getDB("estreaming");
db.createCollection( "splash", { capped: true, size: 500 } );
