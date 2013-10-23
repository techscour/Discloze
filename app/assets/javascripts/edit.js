 var EditController =function($scope, $http) {
    $scope.values = values
    $scope.visibility = $scope.values.visibility;
    $scope.name = $scope.values.name;
    $scope.user_id = $scope.values.user_id;
    $scope.id = $scope.values.id
    $scope.rating = 5;
    $scope.item = '';
    $scope.item_dirty = false;
    $scope.rating_dirty = false;
    $scope.editing = false;
    $scope.duplicate = false;
    $scope.alertMessage = '';
    $scope.edits = 0;
    $scope.mail_to = '';
    $scope.subject = '';
    $scope.body = '';
    $scope.mySelections = [];
    $scope.columns = [  
      {field:'rating', displayName: 'Rating'},
      {field:'item', displayName: 'Item'}
    ];
    $scope.sortInfo = [{ fields:[('item')], directions: [('asc')]}];

    $scope.theData = JSON.parse($scope.values.data);
    if (!$scope.$$phase) {
      $scope.$apply();
    }

    $scope.gridOptions = {
      data: 'theData',
      columnDefs: $scope.columns,
      selectedItems: $scope.mySelections,
      multiSelect: false
    };

    $scope.rating_change = function()
    {
      $scope.rating_dirty = true;
    };

    $scope.item_change = function()
    {
      $scope.item_dirty = true;
      $scope.editing = false;
      $scope.duplicate = false;
    };

    $scope.selected = function()
    {
      $scope.item = $scope.mySelections[0].item;
      $scope.rating = $scope.mySelections[0].rating;
      $scope.editing = true;
      $scope.rating_dirty = false;
      $scope.item_dirty = false;
    };

    $scope.destroy = function()
    {
      var url = '/lists/' + $scope.id;
      $scope.deleteUrl(url);
    };

    $scope.save = function()
    {
      var saved = { name: $scope.name, visibility: $scope.visibility, 
        values: $scope.theData};
        var url = '/lists/' + $scope.id;
        $scope.putUrl(url,saved);
        $scope.edits = 0;
        window.onbeforeunload = null;
      };

      $scope.cancel = function()
      {
        $('#emailModal').modal('hide');
         window.onbeforeunload = null;
      };

      $scope.send = function()
      {
        var mail = {mail_to: $scope.mail_to, subject: $scope.subject, body: $scope.message,
          list: $scope.name, visibility: $scope.visibility, data: $scope.data};
          var url = '/session/mail';
          $('#emailModal').modal('hide');
          window.onbeforeunload = null;
          $scope.postUrl(url,mail); 
        };

        $scope.email = function()
        {
          $scope.clearEmailForm();
          $scope.subject = 'My ' + $scope.name + ' List';
          $('#emailModal').modal('show');
        };

        $scope.download = function()
        {
          var url = '/session/download?name='+ $scope.name;
          window.location = url;
        };
        $scope.clearEmailForm = function()
        {
          $scope.mail_to = '';
          $scope.subject = '';
          $scope.message = '';
          $scope.clearForm($scope.emailForm,'#emailForm');
          $scope.clearField($scope.emailForm.mail_to,'#mail_to');
          $scope.clearField($scope.emailForm.subject,'#subject');
          $scope.clearField($scope.emailForm.message,'#message');
        };

        $scope.add = function()
        {
         var index = $scope.find();
         if (index != -1)
         {
          $scope.duplicate = true;
          return; 
        }
        var added = {item: $scope.item, rating: parseInt($scope.rating)};
        $scope.theData.unshift(added);
        $scope.edits += 1;
        if ($scope.edits == 1) {
          window.onbeforeunload = function(e) {
            return 'Dialog text here.';
          };
        }
        $scope.clear_item_form();
      };

      $scope.update = function()
      {
        var index = $scope.find();
        var element = $scope.theData[index];
        element.item = $scope.item;
        element.rating = parseInt($scope.rating);
        $scope.edits += 1;
        if ($scope.edits == 1) {

          window.onbeforeunload = function(e) {
            return 'Dialog text here.';
          };
        }
      };

      $scope.find = function() 
      {
        for (i in $scope.theData)
        {
          if ($scope.theData[i].item == $scope.item) return i;
        }
        return -1;
      };

      $scope.delete = function()
      {
        var index = $scope.find();
        $scope.theData.splice(index, 1);
        $scope.clear();
      };

      $scope.clear_item_form = function()
      {
        $scope.rating = 5;
        $scope.item = '';
        $scope.clearForm($scope.itemForm,'#itemForm');
        $scope.clearField($scope.itemForm.item,'#item');
        $scope.editing = false;
        $scope.rating_dirty = false;
        $scope.duplicate = false;
        $scope.item_dirty = false;
      };

      $scope.clearForm = function(form, formSelector)
      {
        $(formSelector).addClass('ng-pristine');
        $(formSelector).removeClass('ng-dirty');
        form.$pristine = true;
        form.$dirty = false;
        form.$valid = true;
        form.$invalid = false;
      };

      $scope.clearField = function(field, fieldSelector)
      {
        $(fieldSelector).addClass('ng-pristine');
        $(fieldSelector).removeClass('ng-dirty');
        field.$pristine = true;
        field.$dirty = false;
        field.$valid = true;
        field.$invalid = false;
      };

      $scope.deleteUrl = function (url) {
          //alert(url);
          setTimeout(function () {
            $http.delete(url).success(function (a) {
              $scope.alertMessage = 'Deleted';
              $('#alertModal').modal('show'); 
              window.onbeforeunload = null;
              window.location = values.root_url;
            }).error(function(a) {
              $scope.alertMessage = 'Delete Failed';
              $('#alertModal').modal('show'); 
            })
          }, 100);
        };
        $scope.putUrl = function (url,data) {
          setTimeout(function () {
            $http.put(url,data).success(function () {
              $scope.alertMessage = 'Updated';
              $('#alertModal').modal('show'); 
              window.onbeforeunload = null;
            }).error(function(a,b,c) {
              $scope.alertMessage = 'Update Failed';
              $('#alertModal').modal('show'); 
            })
          }, 100);
        };
        $scope.postUrl = function (url,data) {
          //alert([url,data]);
          setTimeout(function () {
            $http.post(url,data).success(function () {
              $scope.alertMessage = 'Success';
              $('#alertModal').modal('show'); 
              window.onbeforeunload = null;
            }).error(function(a,b,c) {
              $scope.alertMessage = 'Failed';
              $('#alertModal').modal('show'); 
            })
          }, 100);
        };
        $scope.$watch('mySelections', function (newVal, oldVal) {
          if (newVal !== oldVal) $scope.selected(); }, true);


   
      }