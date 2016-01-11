(function(){
	var client,mysql,settings;

	settings = require("./settings");
	client = null;
	mysql = require("mysql");

    var connection;

  var getDbCon = function() {
    //    var err;
    //    try {
    //        if (client) {
    //            client = mysql.createConnection(settings.db);
    //            client.connect();
    //        } else {
    //            client = new mysql.createConnection(settings.db);
    //            client.connect();
    //        }
    //    } catch (_error) {
    //        err = _error;
    //        throw err;
    //    }
    //    return client;

     connection = mysql.createConnection(settings.db); // Recreate the connection, since
     // the old one cannot be reused.

     connection.connect(function(err) {              // The server is either down
         if(err) {                                     // or restarting (takes a while sometimes).
             console.log('error when connecting to db:', err);
             setTimeout(getDbCon, 2000); // We introduce a delay before attempting to reconnect,
         }                                     // to avoid a hot loop, and to allow our node script to
     });                                     // process asynchronous requests in the meantime.
                                             // If you're also serving http, display a 503 error.
     connection.on('error', function(err) {
         console.log('db error', err);
         if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
             getDbCon();                         // lost due to either server restart, or a
         } else {                                      // connnection idle timeout (the wait_timeout
             throw err;                                  // server variable configures this)
         }
     });

     };

    exports.getDbCon = getDbCon;
}).call(this);