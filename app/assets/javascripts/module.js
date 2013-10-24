theModule = angular.module('theModule', ['ngGrid','ui.bootstrap']).config([
  "$httpProvider", function($httpProvider) {
  csrfToken = $('meta[name=csrf-token]').attr('content');
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = csrfToken;
 }
]);

