
U = {
  views: {
    addritems: {},
    cities: {},
    days: {},
    galleries: {},
    places: {},
    reports: {},
    sites: {},
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
ManagerModels = {}
// @deprecated, Collections is not used.
Collections = {}
Views = {
  Addritems: {},
  Cities: {},
  CitiesUsers: {},
  Days: {},
  Galleries: {},
  Places: {},
  Reports: {},
  Sites: {},
  Users: {},
  Venues: {},
  Videos: {}
}
ManagerViews = {
  Galleries: {}
}

AppTrash = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {
    Addritems: {},
    Cities: {}, City: {},
    CitiesUsers: {},
    Reports: {},
    Sites: {},
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







