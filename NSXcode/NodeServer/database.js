(function(){
    var client,mysql,settings;

    settings = require("./settings");
    client = null;
    mysql = require("mysql");

    var connection;

    exports.getDbCon = function() {
        var err;
        try {
            if (client) {
                client = mysql.createConnection(settings.db);
                client.connect();
            } else {
                client = new mysql.createConnection(settings.db);
                client.connect();
            }
        } catch (_error) {
            err = _error;
            if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
                client = new mysql.createConnection(settings.db);
                client.connect();                         // lost due to either server restart, or a
            } else {                                      // connnection idle timeout (the wait_timeout
                throw err;                                  // server variable configures this)
            }
        }
        return client;
    };

    //exports.getDbCon = getDbCon;
}).call(this);