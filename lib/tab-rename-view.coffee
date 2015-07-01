{View, TextEditorView} = require 'atom-space-pen-views'

module.exports =
class TabRenameView extends View
  @content: ->
    @div =>
      @div class: "tabl-heading", =>
        @div "Rename tab to:", class: "message"
      @div class: "tabl-body padded", =>
        @subview 'nameEditor', new TextEditorView(mini:true, placeholderText: 'Tab Name')
