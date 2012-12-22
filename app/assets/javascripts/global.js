

// header footer
HF = {}

// Utils & units
// temp init objects
U = {
  views: {
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


// both this and App.<whatever> are needed.
Views = {
  Cities: {},
  Days: {},
  Galleries: {},
  Places: {},
  Reports: {},
  Users: {},
  Venues: {},
  Videos: {}
}

Models = {}

Collections = {}

App = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {
    Addritems: {},
    Cities: {},
    CitiesUsers: {},
    Places: {},
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
  left_menu: ".left-menu"
  
});







