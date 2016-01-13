//(function(){
//    var client,mysql,settings;
//
//    settings = require("./settings");
//    client = null;
//    mysql = require("mysql");
//
//    var connection;
//
//    exports.getDbCon = function() {
//        var err;
//        try {
//            if (client) {
//                client = mysql.createConnection(settings.db);
//                client.connect();
//            } else {
//                client = new mysql.createConnection(settings.db);
//                client.connect();
//            }
//        } catch (_error) {
//            err = _error;
//            if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
//                client = new mysql.createConnection(settings.db);
//                client.connect();                         // lost due to either server restart, or a
//            } else {                                      // connnection idle timeout (the wait_timeout
//                throw err;                                  // server variable configures this)
//            }
//        }
//        return client;
//    };
//
//    //exports.getDbCon = getDbCon;
//}).call(this);

var mysql = require('mysql'),
    settings = require('./settings');

module.exports.getDbCon = function () {
    if ((module.exports.connection) && (module.exports.connection._socket)
        && (module.exports.connection._socket.readable)
        && (module.exports.connection._socket.writable)) {
        return module.exports.connection;
    }
    console.log(((module.exports.connection) ?
            "UNHEALTHY SQL CONNECTION; RE" : "") + "CONNECTING TO SQL.");
    var connection =mysql.createConnection(settings.db);
    connection.connect(function (err) {
        if (err) {
            console.log("SQL CONNECT ERROR: " + err);
        } else {
            console.log("SQL CONNECT SUCCESSFUL.");
        }
    });
    connection.on("close", function (err) {
        console.log("SQL CONNECTION CLOSED.");
    });
    connection.on("error", function (err) {
        console.log("SQL CONNECTION ERROR: " + err);
    });
    module.exports.connection = connection;
    return module.exports.connection;
};

// Open a connection automatically at app startup.
module.exports.getDbCon();