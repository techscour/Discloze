describe('Edit Controller', function() {
  var $scope = null;
  var ctrl = null;
  var $httpBackend = null;

  beforeEach(module('theModule'));

  beforeEach(inject(function($rootScope, $controller, $http, $httpBackend, $window,$timeout) {
    $scope = $rootScope.$new();
    var inputs_json = '{"data":[{"item":"item 1","rating":8},{"item":"item 2","rating":7}],"name":"list name 1","visibility":"Public","user_id":null,"id":"1"}';
    $window.theEditValues = JSON.parse(inputs_json);
    $window.theEditValues["data"] = JSON.stringify($window.theEditValues["data"]);
    controller = $controller('EditController', {
      $scope: $scope,
      $http: $http,
      $window: $window
    });
    http = $http;
    httpMock = $httpBackend;
    timeout = $timeout; 
    windowMock = $window;
  }));

  afterEach(function() {
     httpMock.verifyNoOutstandingExpectation();
     httpMock.verifyNoOutstandingRequest();
   });

  it("binds edit values correctly", function() {
    expect($scope.visibility).toBe('Public');
    expect($scope.name).toBe('list name 1');
    expect($scope.id).toBe('1');
	expect($scope.theData.length).toBe(2);
  });


  it("delete requests are sent", function() {
    $scope.useTimeouts = false;
    httpMock.when('DELETE','/something/1').respond(200,'');
    httpMock.expect('DELETE','/something/1');
    $scope.deleteUrl('/something/1');
    httpMock.flush();
    });

  it("post requests are sent", function() {
    $scope.useTimeouts = false;
    httpMock.when('POST','/something/1').respond(200,'');
    httpMock.expect('POST','/something/1');
    $scope.postUrl('/something/1');
    httpMock.flush();
    });

  it("put requests are sent", function() {
    $scope.useTimeouts = false;
    httpMock.when('PUT','/something/1').respond(200,'');
    httpMock.expect('PUT','/something/1');
    $scope.putUrl('/something/1');
    httpMock.flush();
    });

});
