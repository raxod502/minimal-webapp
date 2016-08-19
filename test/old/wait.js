// Adapted from http://stackoverflow.com/a/27472788/3538165

var system = require("system");
var args = system.args;

if (args.length !== 2) {
  console.log("usage: phantomjs get_html.js <url>");
  phantom.exit();
}

var page = require("webpage").create();
var url = args[1];

page.open(url, function (status) {
    function check() {
        var content = page.evaluate(function() {
            return document.documentElement.outerHTML;
        });
        console.log(content);
        setTimeout(check, 1000);
    }
    check();
});