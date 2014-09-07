//= require raptor

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
