/* global jQuery, $ */

jQuery(() => {
  $('a[rel~=popover], .has-popover').popover();
  return $('a[rel~=tooltip], .has-tooltip').tooltip();
});
