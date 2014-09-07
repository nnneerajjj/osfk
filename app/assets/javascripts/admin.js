//= require raptor
//= require forms

raptor(function($) {

  var options = function(type) {
    return {
      plugins: {
        statistics: false,
        languageMenu: false,
        colorMenuBasic: false,
        alignJustify: false,
        textSizeDecrease: false,
        textSizeIncrease: false,

        tableCreate: false,
        tableDeleteColumn: false,
        tableDeleteRow: false,
        tableInsertColumn: false,
        tableInsertRow: false,
        tableMergeCells: false,
        tableSplitCells: false,
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
        viewSource: false,
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
  $("#s3-uploader").S3Uploader();

  $('#s3-uploader').bind("s3_upload_complete", function(e, content) {
    console.log(content);
    $table = $('.uploads');
    $tr = $('<tr></tr>');
    console.log($table.data('loader'));
    var $img = $('<img>')
    $img.attr('src', $table.data('loader'));
    $td = $('<td id="' + content.unique_id + '"></td>')
    $img.appendTo($td);
    $td.appendTo($tr);
    $('<td>' + content.filename + '</td>').appendTo($tr);
    $('<td>' + bytesToSize(content.filesize) + '</td>').appendTo($tr);
    $('<td></td>').appendTo($tr);
    $tr.appendTo($table);
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
