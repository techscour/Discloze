var jsApiReporter;!function(){function execJasmine(){jasmineEnv.execute()}var jasmineEnv=jasmine.getEnv();jsApiReporter=new jasmine.JsApiReporter,jasmineEnv.addReporter(jsApiReporter);var htmlReporter=new jasmine.HtmlReporter;jasmineEnv.addReporter(htmlReporter),jasmineEnv.specFilter=function(spec){return htmlReporter.specFilter(spec)},jasmine.ConsoleReporter&&jasmineEnv.addReporter(new jasmine.ConsoleReporter),window.addEventListener?window.addEventListener("load",execJasmine,!1):window.attachEvent&&window.attachEvent("onload",execJasmine)}();