//
//= require jasmine-1.1.0/jasmine
//= require jasmine-1.1.0/jasmine-html
//
//= require ./spec/piousbox/cities_spec_application
//= require ./spec/piousbox/cities_spec_m
//

(function() {
    var jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;
    
    var trivialReporter = new jasmine.TrivialReporter();
    
    jasmineEnv.addReporter(trivialReporter);
    
    jasmineEnv.specFilter = function(spec) {
	return trivialReporter.specFilter(spec);
    };
    
    var currentWindowOnload = window.onload;

    window.onload = function() {
	if (currentWindowOnload) {
            currentWindowOnload();
	}
	execJasmine();
    };
    
    function execJasmine() {
	jasmineEnv.execute();
    }
    
})();
