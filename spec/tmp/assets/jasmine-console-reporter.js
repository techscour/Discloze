!function(jasmine,console){if(!jasmine)throw"jasmine library isn't loaded!";var ANSI={};ANSI.color_map={green:32,red:31},ANSI.colorize_text=function(text,color){var color_code=this.color_map[color];return"["+color_code+"m"+text+"[0m"};var ConsoleReporter=function(){if(!console||!console.log)throw"console isn't present!";this.status=this.statuses.stopped},proto=ConsoleReporter.prototype;proto.statuses={stopped:"stopped",running:"running",fail:"fail",success:"success"},proto.reportRunnerStarting=function(){this.status=this.statuses.running,this.start_time=(new Date).getTime(),this.executed_specs=0,this.passed_specs=0,this.log("Starting...")},proto.reportRunnerResults=function(){var failed=this.executed_specs-this.passed_specs,spec_str=this.executed_specs+(1===this.executed_specs?" spec, ":" specs, "),fail_str=failed+(1===failed?" failure in ":" failures in "),color=failed>0?"red":"green",dur=(new Date).getTime()-this.start_time;this.log(""),this.log("Finished"),this.log("-----------------"),this.log(spec_str+fail_str+dur/1e3+"s.",color),this.status=failed>0?this.statuses.fail:this.statuses.success,this.log(""),this.log("ConsoleReporter finished")},proto.reportSpecStarting=function(){this.executed_specs++},proto.reportSpecResults=function(spec){if(!spec.results().skipped){if(spec.results().passed())return this.passed_specs++,void 0;var resultText=spec.suite.description+" : "+spec.description;this.log(resultText,"red");for(var items=spec.results().getItems(),i=0;i<items.length;i++){var item=items[i],output="  "+item.message;this.log(output,"red")}}},proto.reportSuiteResults=function(suite){if(!suite.parentSuite){var results=suite.results();if(0!==results.totalCount){var failed=results.totalCount-results.passedCount,color=failed>0?"red":"green";this.log(suite.description+": "+results.passedCount+" of "+results.totalCount+" passed.",color)}}},proto.log=function(str,color){var text=void 0!=color?ANSI.colorize_text(str,color):str;console.log(text)},jasmine.ConsoleReporter=ConsoleReporter}(jasmine,console);