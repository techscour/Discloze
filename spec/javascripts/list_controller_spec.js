describe('List Controller', function() {
  var $scope = null;
  var ctrl = null;
  var $httpBackend = null;

  beforeEach(module('theModule'));

  beforeEach(inject(function($rootScope, $controller, $http, $httpBackend, $window,$timeout) {
    $scope = $rootScope.$new();
    var inputs_json = '{"data":[{"id":1,"name":"list name 1","visibility":"Public"},{"id":2,"name":"list name 2","visibility":"Public"},{"id":3,"name":"list name 3","visibility":"Public"},{"id":4,"name":"list name 4","visibility":"Public"},{"id":5,"name":"list name 5","visibility":"Public"},{"id":6,"name":"list name 6","visibility":"Public"},{"id":7,"name":"list name 7","visibility":"Public"},{"id":8,"name":"list name 8","visibility":"Public"},{"id":9,"name":"list name 9","visibility":"Public"},{"id":10,"name":"list name 10","visibility":"Public"}],"total":25,"columns":[{"field":"name","displayName":"Name","order":"name"},{"field":"visibility","displayName":"Visbility","order":"visibility"}],"size":10,"page":1,"field":"id","direction":"asc","header":"My Lists","callbacks":{"edit":{"controller":"lists"}},"user_id":1,"fat":"3xswxvaGOtm05y5UWeJiLPhIPtx09wnFYU7no3uuIF0="}';
    $window.theListValues = JSON.parse(inputs_json);
    controller = $controller('ListController', {
      $scope: $scope,
      $http: $http,
      $window: $window
    });
    $scope.gridOptions.selectedItems = [];
    $scope.mySelections = [$scope.theData[0]];
    http = $http;
    httpMock = $httpBackend;
    timeout = $timeout; 
    windowMock = $window;
  }));

  afterEach(function() {
     httpMock.verifyNoOutstandingExpectation();
     httpMock.verifyNoOutstandingRequest();
   });

  it("binds list values correctly", function() {
    expect($scope.maxSize).toBe(10);
    expect(JSON.stringify($scope.sortInfo)).toBe('[{"fields":["\'id\'"],"directions":["\'asc\'"]}]');
    expect($scope.theData.length).toBe(10);
    expect($scope.totalItems).toBe(25);
    expect($scope.userId).toBe(1);
    expect($scope.authenticity_token).toBe("3xswxvaGOtm05y5UWeJiLPhIPtx09wnFYU7no3uuIF0=");
    expect($scope.callbacks["edit"]).not.toBe(undefined);
    expect($scope.currentPage).toBe(1);
  });

  it("edit redirects to the edit controller", function() {
    $scope.edit();
    expect($scope.test_location).toBe('/edits/1/edit')
    });

  it("delete requests send DELETE to controller#delete", function() {
    $scope.useTimeouts = false;
    httpMock.when('DELETE','/something/1').respond(200,'');
    httpMock.expect('DELETE','/something/1');
    $scope.deleteUrl('/something/1');
    httpMock.flush();
    });

  it("create requests send POST to controller#create", function() {
    $scope.useTimeouts = false;
    httpMock.when('POST','/something/1').respond(200,'');
    httpMock.expect('POST','/something/1');
    $scope.createUrl('/something/1');
    httpMock.flush();
    });

});




