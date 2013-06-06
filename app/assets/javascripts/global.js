
U = {
  views: {
    addritems: {},
    cities: {},
    days: {},
    galleries: {},
    places: {},
    reports: {},
    users: {},
    venues: {},
    videos: {}

  },
  models: {},
  dropbox: {},
  trash: {
    sanity: 'saaanty'
  }
}

CanvasOps = {}
Utils = {}
// header footer
HF = {}

Models = {}
Collections = {}
Views = {
  Addritems: {},
  Cities: {},
  CitiesUsers: {},
  Days: {},
  Galleries: {},
  Places: {},
  Reports: {},
  Users: {},
  Venues: {},
  Videos: {}
}

AppTrash = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {
    Addritems: {},
    Cities: {},
    CitiesUsers: {},
    Reports: {},
    Users: {},
    Venues: {},
    Videos: {}
  }
}

MyApp = new Backbone.Marionette.Application();

MyApp.addRegions({
  right_region: ".right-container .inner",
  left_region: ".left-container .inner",

  right_menu: ".right-menu",
  left_menu: ".left-menu",

  manager_menu: '.manager-menu',
  manager_region: '.manager-region'
  
});







