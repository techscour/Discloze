theListController =function($scope, $http, $window) {

      $scope.values = $window.theListValues
      $scope.maxSize = parseInt($scope.values.size);
      $scope.sortInfo = [{ fields:[("'" + $scope.values.field + "'")], 
        directions: [("'" + $scope.values.direction+ "'")]}];
      $scope.totalItems = parseInt($scope.values.total);
      $scope.currentPage = parseInt($scope.values.page);
      $scope.userId = parseInt($scope.values.user_id);
      $scope.mySelections = [];
      //$scope.id = -1;
      $scope.useTimeouts = true;
      $scope.authenticity_token = $scope.values.fat;
      $scope.alertMessage = 'EMPTY';
      $scope.callbacks = $scope.values.callbacks;

      $scope.deleting = !!$scope.callbacks['delete'];
      $scope.creating = !!$scope.callbacks['create'];
      $scope.editing = !!$scope.callbacks['edit'];

      $scope.gridOptions = {
        data: 'theData',
        enablePaging: true,
        sortinfo: $scope.sortInfo,
        showFooter: false,
        useExternalSorting: true,
        columnDefs: $scope.values.columns,
        selectedItems: $scope.mySelections,
        multiSelect: false,
        filterOptions: $scope.filterOptions
      };

      $scope.theData = $scope.values.data;
      if (!$scope.$$phase) {
        $scope.$apply();
      }

      $scope.edit = function()
      {
        var id = $scope.mySelections[0].id;
        $scope.test_location = '/edits/' + id + '/edit';
        $window.location = '/edits/' + id + '/edit';
      };

      $scope.delete = function()
      {
        var controller = $scope.callbacks['delete'].controller;
        var id = $scope.mySelections[0].id;
        url = '/' + controller + '/' + id;
        $scope.deleteUrl(url);
      };
      $scope.create = function()
      {
        var controller = $scope.callbacks['create'].controller;
        var id = $scope.mySelections[0].id;
        url = '/' + controller
        $scope.createUrl(url,id); 
      };
      //$scope.view = function()
      //{
        //var html = null;
        //angular.forEach($scope.theData, function(x) {
          //if (x.id == $scope.mySelections[0].id) html = x.html;
          //});
        //$('#htmlContent').html(html);
        //$('#emailModal').modal('show');
      //};
      $scope.getNextPage = function()
      {
        var size = $scope.maxSize;
        var page = $scope.currentPage;
        var field = $scope.gridOptions.ngGrid.config.sortInfo.fields[0];
        var direction = $scope.gridOptions.ngGrid.config.sortInfo.directions[0];
        var base = $window.location.toString().split('?', 1);
        var url = base + '?size=' + size + '&page=' + page + '&field=' + field + '&direction=' + direction;
        $window.location =  base + '?size=' + size + '&page=' + page + '&field=' + field + '&direction=' + direction;
      };
      $scope.deleteUrl = function (url) {
          var deleter = function () {
                $http.delete(url).success(function () {
                      $scope.alertMessage = 'Deleted';
                      $('#alertModal').modal('show'); 
                  }).error(function(a,b,c) {
                      $scope.alertMessage = 'Delete Failed';
                      $('#alertModal').modal('show'); 
                  })
                };
          if ($scope.useTimeouts) setTimeout(deleter, 100);
          else deleter();
      };
      $scope.createUrl = function (url,data) {
          var creater = function () {
                $http.post(url,data).success(function (a) {
                      $scope.alertMessage = a;
                      $('#alertModal').modal('show'); 
                  }).error(function(a,b,c) {
                    $scope.alertMessage = a;
                    $('#alertModal').modal('show'); 
                  })
              };
          if ($scope.useTimeouts) setTimeout(creater, 100);
          else creater();
      };
      $scope.$watch('maxSize', function (newVal, oldVal) {
        if (newVal !== oldVal) $scope.getNextPage(); }, true);

      $scope.$watch('currentPage', function (newVal, oldVal) {
        if (newVal !== oldVal) $scope.getNextPage(); }, true);

      $scope.$watch('gridOptions.ngGrid.config.sortInfo', function (newVal, oldVal) {
        if (newVal !== oldVal) $scope.getNextPage(); }, true);

      $scope.$watch('mySelections', function (newVal, oldVal) {
        if (newVal !== oldVal) console.log('selection'); }, true);

      $('#alertModal').on('hidden', function () {
        $scope.getNextPage();
      });
  }

  theModule.controller('ListController',theListController);