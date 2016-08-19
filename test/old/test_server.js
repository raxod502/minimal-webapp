var system = require('system');
var args = system.args;

var usage = [
    'usage: phantomjs test_server.js',
    '       ([on error [do not]]',
    '        (run command <command> |',
    '         launch <process_name> with command <command> |',
    '         wait for <process_name> to terminate [with timeout of <seconds> seconds] |',
    '         send input <input> to <process_name> |',
    '         kill <process_name> |',
    '         on port <port> |',
    '         at (path <path> | root path) |',
    '         (reload | wait) until text <text> observed [with timeout of <seconds> seconds] |',
    '         wait until alert observed [with timeout of <seconds> seconds] |',
    '         wait <seconds> seconds |',
    '         wait until text <text> observed in file <filename> [with timeout of <seconds> seconds])',
    '        clear error handlers])+'].join('\n');



var port = args[1];
var health_check_url = 'http://localhost:' + port + '/health-check'
var
var url = 'http://localhost:'

var page = require('webpage').create();
var
