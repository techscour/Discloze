theListController =function($s, $h, $w) {
      $s.values = $w.theListValues
      $s.maxSize = parseInt($s.values.size);
      $s.sortInfo = [{ fields:[("'" + $s.values.field + "'")], 
        directions: [("'" + $s.values.direction+ "'")]}];
      $s.totalItems = parseInt($s.values.total);
      $s.currentPage = parseInt($s.values.page);
      $s.userId = parseInt($s.values.user_id);
      $s.mySelections = [];
      $s.useTimeouts = true;
      $s.authenticity_token = $s.values.fat;
      $s.alertMessage = 'EMPTY';
      $s.callbacks = $s.values.callbacks;

      $s.deleting = !!$s.callbacks['delete'];
      $s.creating = !!$s.callbacks['create'];
      $s.editing = !!$s.callbacks['edit'];

      $s.gridOptions = {
        data: 'theData',
        enablePaging: true,
        sortinfo: $s.sortInfo,
        showFooter: false,
        useExternalSorting: true,
        columnDefs: $s.values.columns,
        selectedItems: $s.mySelections,
        multiSelect: false,
        filterOptions: $s.filterOptions
      };

      $s.theData = $s.values.data;
      if (!$s.$$phase) {
        $s.$apply();
      }

      $s.edit = function()
      {
        var id = $s.mySelections[0].id;
        $s.test_location = '/edits/' + id + '/edit';
        $w.location = '/edits/' + id + '/edit';
      };

      $s.delete = function()
      {
        var controller = $s.callbacks['delete'].controller;
        var id = $s.mySelections[0].id;
        url = '/' + controller + '/' + id;
        $s.deleteUrl(url);
      };
      $s.create = function()
      {
        var controller = $s.callbacks['create'].controller;
        var id = $s.mySelections[0].id;
        url = '/' + controller
        $s.createUrl(url,id); 
      };
      $s.getNextPage = function()
      {
        var size = $s.maxSize;
        var page = $s.currentPage;
        var field = $s.gridOptions.ngGrid.config.sortInfo.fields[0];
        var direction = $s.gridOptions.ngGrid.config.sortInfo.directions[0];
        var base = $w.location.toString().split('?', 1);
        var url = base + '?size=' + size + '&page=' + page + '&field=' + field + '&direction=' + direction;
        $w.location =  base + '?size=' + size + '&page=' + page + '&field=' + field + '&direction=' + direction;
      };
      $s.deleteUrl = function (url) {
          var deleter = function () {
                $h.delete(url).success(function () {
                      $s.alertMessage = 'Deleted';
                      $('#alertModal').modal('show'); 
                  }).error(function(a,b,c) {
                      $s.alertMessage = 'Delete Failed';
                      $('#alertModal').modal('show'); 
                  })
                };
          if ($s.useTimeouts) setTimeout(deleter, 100);
          else deleter();
      };
      $s.createUrl = function (url,data) {
          var creater = function () {
                $h.post(url,data).success(function (a) {
                      $s.alertMessage = a;
                      $('#alertModal').modal('show'); 
                  }).error(function(a,b,c) {
                    $s.alertMessage = a;
                    $('#alertModal').modal('show'); 
                  })
              };
          if ($s.useTimeouts) setTimeout(creater, 100);
          else creater();
      };
      $s.$watch('maxSize', function (newVal, oldVal) {
        if (newVal !== oldVal) $s.getNextPage(); }, true);

      $s.$watch('currentPage', function (newVal, oldVal) {
        if (newVal !== oldVal) $s.getNextPage(); }, true);

      $s.$watch('gridOptions.ngGrid.config.sortInfo', function (newVal, oldVal) {
        if (newVal !== oldVal) $s.getNextPage(); }, true);

      $s.$watch('mySelections', function (newVal, oldVal) {
        if (newVal !== oldVal) console.log('selection'); }, true);

      $('#alertModal').on('hidden', function () {
        $s.getNextPage();
      });
  }
  theListController.$inject = ['$scope','$http','$window'];
  theModule.controller('ListController',theListController);