theEditController =function($s, $h, $w) {
    $s.values = $w.theEditValues;
    $s.visibility = $s.values.visibility;
    $s.name = $s.values.name;
    $s.user_id = $s.values.user_id;
    $s.id = $s.values.id
    $s.rating = 5;
    $s.item = '';
    $s.item_dirty = false;
    $s.rating_dirty = false;
    $s.editing = false;
    $s.duplicate = false;
    $s.alertMessage = '';
    $s.edits = 0;
    $s.mail_to = '';
    $s.subject = '';
    $s.body = '';
    $s.mySelections = [];
    $s.useTimouts = true;
    $s.columns = [  
      {field:'rating', displayName: 'Rating'},
      {field:'item', displayName: 'Item'}
    ];
    $s.sortInfo = [{ fields:[('item')], directions: [('asc')]}];

    $s.theData = JSON.parse($s.values.data);
    if (!$s.$$phase) {
      $s.$apply();
    }

    $s.gridOptions = {
      data: 'theData',
      columnDefs: $s.columns,
      selectedItems: $s.mySelections,
      multiSelect: false
    };

    $s.rating_change = function()
    {
      $s.rating_dirty = true;
    };

    $s.item_change = function()
    {
      $s.item_dirty = true;
      $s.editing = false;
      $s.duplicate = false;
    };

    $s.selected = function()
    {
      $s.item = $s.mySelections[0].item;
      $s.rating = $s.mySelections[0].rating;
      $s.editing = true;
      $s.rating_dirty = false;
      $s.item_dirty = false;
    };

    $s.destroy = function()
    {
      var url = '/lists/' + $s.id;
      $s.deleteUrl(url);
    };

    $s.save = function()
    {
      var saved = { name: $s.name, visibility: $s.visibility, 
        values: $s.theData};
        var url = '/lists/' + $s.id;
        $s.putUrl(url,saved);
        $s.edits = 0;
        $w.onbeforeunload = null;
      };

      $s.cancel = function()
      {
        $('#emailModal').modal('hide');
         $w.onbeforeunload = null;
      };

      $s.send = function()
      {
        var mail = {mail_to: $s.mail_to, subject: $s.subject, body: $s.message,
          list: $s.name, visibility: $s.visibility, data: $s.data};
          var url = '/session/mail';
          $('#emailModal').modal('hide');
          $w.onbeforeunload = null;
          $s.postUrl(url,mail); 
        };

        $s.email = function()
        {
          $s.clearEmailForm();
          $s.subject = 'My ' + $s.name + ' List';
          $('#emailModal').modal('show');
        };

        $s.download = function()
        {
          var url = '/session/download?name='+ $s.name;
          $w.location = url;
        };
        $s.clearEmailForm = function()
        {
          $s.mail_to = '';
          $s.subject = '';
          $s.message = '';
          $s.clearForm($s.emailForm,'#emailForm');
          $s.clearField($s.emailForm.mail_to,'#mail_to');
          $s.clearField($s.emailForm.subject,'#subject');
          $s.clearField($s.emailForm.message,'#message');
        };

        $s.add = function()
        {
         var index = $s.find();
         if (index != -1)
         {
          $s.duplicate = true;
          return; 
        }
        var added = {item: $s.item, rating: parseInt($s.rating)};
        $s.theData.unshift(added);
        $s.edits += 1;
        if ($s.edits == 1) {
          $w.onbeforeunload = function(e) {
            return 'You have unsaved list edits.';
          };
        }
        $s.clear_item_form();
      };

      $s.update = function()
      {
        var index = $s.find();
        var element = $s.theData[index];
        element.item = $s.item;
        element.rating = parseInt($s.rating);
        $s.edits += 1;
        if ($s.edits == 1) {

          $w.onbeforeunload = function(e) {
            return 'Dialog text here.';
          };
        }
      };

      $s.find = function() 
      {
        for (i in $s.theData)
        {
          if ($s.theData[i].item == $s.item) return i;
        }
        return -1;
      };

      $s.delete = function()
      {
        var index = $s.find();
        $s.theData.splice(index, 1);
        $s.clear();
      };

      $s.clear_item_form = function()
      {
        $s.rating = 5;
        $s.item = '';
        $s.clearForm($s.itemForm,'#itemForm');
        $s.clearField($s.itemForm.item,'#item');
        $s.editing = false;
        $s.rating_dirty = false;
        $s.duplicate = false;
        $s.item_dirty = false;
      };

      $s.clearForm = function(form, formSelector)
      {
        $(formSelector).addClass('ng-pristine');
        $(formSelector).removeClass('ng-dirty');
        form.$pristine = true;
        form.$dirty = false;
        form.$valid = true;
        form.$invalid = false;
      };

      $s.clearField = function(field, fieldSelector)
      {
        $(fieldSelector).addClass('ng-pristine');
        $(fieldSelector).removeClass('ng-dirty');
        field.$pristine = true;
        field.$dirty = false;
        field.$valid = true;
        field.$invalid = false;
      };

      $s.deleteUrl = function (url) {
          var deleter = function () {
            $h.delete(url).success(function (a) {
              $s.alertMessage = 'Deleted';
              $('#alertModal').modal('show'); 
              $w.onbeforeunload = null;
              $w.location = '/';
            }).error(function(a) {
              $s.alertMessage = 'Delete Failed';
              $('#alertModal').modal('show'); 
            })
          };
          if ($s.useTimeouts) setTimeout(deleter, 100);
          else deleter();
        };
        $s.putUrl = function (url,data) {
          var putter = function () {
            $h.put(url,data).success(function () {
              $s.alertMessage = 'Updated';
              $('#alertModal').modal('show'); 
              $w.onbeforeunload = null;
            }).error(function(a,b,c) {
              $s.alertMessage = 'Update Failed';
              $('#alertModal').modal('show'); 
            })
          };
          if ($s.useTimeouts) setTimeout(putter, 100);
          else putter();
        };
        $s.postUrl = function (url,data) {
          var poster = function () {
            $h.post(url,data).success(function () {
              $s.alertMessage = 'Success';
              $('#alertModal').modal('show'); 
              $w.onbeforeunload = null;
            }).error(function(a,b,c) {
              $s.alertMessage = 'Failed';
              $('#alertModal').modal('show'); 
            })
          };
          if ($s.useTimeouts) setTimeout(poster, 100);
          else poster();
        };
        $s.$watch('mySelections', function (newVal, oldVal) {
          if (newVal !== oldVal) $s.selected(); }, true);
    }
theEditController.$inject = ['$scope','$http','$window']
theModule.controller('EditController',theEditController);