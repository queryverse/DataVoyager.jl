var libvoyager = require('datavoyager');

var container = document.getElementById("root");
var config = {
    showDataSourceSelector: false,
    hideHeader: true,
    hideFooter: true
}
global.voyagerInstance = libvoyager.CreateVoyager(container, config, undefined)
