describe('theModule', function() {

  it("uses angular 1.0.8", function() {
    expect(angular.version.full).toBe("1.0.8");
  });
  
  it("is registered with angular", function() {
  	theModule = angular.module('theModule');
    expect(theModule.name).toBe('theModule');
  });
  
});

