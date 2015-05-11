//= require raptor
//= require forms
//= require jquery.highlight-4

raptor(function($) {

  var options = function(type) {
    return {
      plugins: {
        statistics: false,
        languageMenu: false,
        colorMenuBasic: true,
        alignJustify: false,
        textSizeDecrease: true,
        textSizeIncrease: true,

        tableCreate: true,
        tableDeleteColumn: true,
        tableDeleteRow: true,
        tableInsertColumn: true,
        tableInsertRow: true,
        tableMergeCells: true,
        tableSplitCells: true,
        dockToElement: true,
        revisions: false,
        clearFormatting: false,
        specialCharacters: false,
        fontFamilyMenu: false,
        historyRedo: true,
        historyUndo: true,
        alignCenter: false,
        alignJustify: false,
        alignLeft: false,
        alignRight: false,
        tagMenu: false,
        viewSource: true,
        textBlockQuote: false,
        hrCreate: false,
        embed: false,
        floatLeft: false,
        floatNone: false,
        floatRight: false,
        textSub: false,
        textSuper: false,
        guides: false,

        // fileManager: false,
        // imageEditor: false,

        dock: {
          //  dockToElement: true
        },

        // The save UI plugin/button
        save: {
            // Specifies the UI to call the saveJson plugin to do the actual saving
            plugin: 'saveJson',
        },
        saveJson: {
          // The URI to send the content to
          url: '/texts',
          // The POST parameter name to use (e.g. for $_POST['raptor-content'] in PHP)
          postName: 'text',
          // The ID of the content (or a function the returns the ID)
          id: function() {
            $el = this.raptor.getElement();
            return $el.data('type') + "-" + $el.data('id') + "-" + $el.data('attr');
          }
        }
      }
    }
  }

  $('.text-edit').raptor(options('text'));
});


$(function() {
  $(".upload-form").S3Uploader();

  $('.upload-form').bind("s3_uploads_start", function(e, content) {
    if ($(".upload-form").data('single')) {
      $("#file").hide();
    }
  });

  $('.upload-form').bind("s3_upload_complete", function(e, content) {
    $loader = $('#image-loader').clone();
    $tbody = $('.uploads tbody');
    $tr = $('<tr></tr>');
    $td = $('<td id="' + content.unique_id + '"></td>');
    $loader.show();
    $loader.appendTo($td);
    $td.appendTo($tr);
    $('<td>' + content.filename + '</td>').appendTo($tr);
    $('<td>' + bytesToSize(content.filesize) + '</td>').appendTo($tr);
    $('<td><button class="remove-image">Ta bort fil</button></td>').appendTo($tr);
    $tr.appendTo($tbody);
  });

  $('[data-size]').each(function() {
    $(this).text(bytesToSize($(this).data('size')));
  });

  $('.uploads').on('click',' .remove-image', function() {
    $tr = $(this).parent().parent();
    if (confirm('Är du säker på att du vill ta bort filen?')) {
      $tr.remove();
      $("#file").show();
    }
  });

  $('[data-form="start_date_date"]').focusout(function() {
    var $startDate = $(this);
    var $endDate = $('[data-form="end_date_date"')
    if ($startDate.val() && !$endDate.val()) {
      $endDate.val($startDate.val());
    }
  });
});

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});


function bytesToSize(bytes) {
   if(bytes == 0) return '0 Byte';
   var k = 1000;
   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
   var i = Math.floor(Math.log(bytes) / Math.log(k));
   return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
}
