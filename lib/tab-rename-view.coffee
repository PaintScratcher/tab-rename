{EditorView, View} = require 'atom'

module.exports =
class tabRenameView extends View
  @content: ->
     @div class: 'tab-rename overlay from-top', =>
       @div class: "inset-tabl", =>
         @div class: "tabl-heading", =>
           @div "Rename tab to:", class: "message"
        @div class: "tabl-body padded", =>
          @subview 'nameEditor', new EditorView(mini:true, placeholderText: 'Tab Name')

  initialize: (serializeState) ->
    atom.workspaceView.command "tab-rename:open", => @open()
    atom.workspaceView.command "tab-rename:rename", => @rename()
    atom.workspaceView.command "tab-rename:renameKeyboard", => @renameKeyboard()
    atom.workspaceView.command "tab-rename:renameClick", => @renameClick()

  # Tear down any state and detach
  destroy: ->
    @detach()

  open: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
    @nameEditor.setText("")
    @nameEditor.focus()
    @handleEvents()

  renameClick: ->
    @elementName = atom.workspaceView.getActivePane()[0].querySelector('.tab.sortable.right-clicked').querySelector('.title')
    @open()


  renameKeyboard: ->
    @elementName = atom.workspaceView.getActivePane()[0].querySelector('.tab.active').querySelector('.title')
    @open()

  rename: ->
    @elementName.innerText = @nameEditor.getText()
    @destroy()

   handleEvents: ->
    @nameEditor.on 'core:confirm', => @rename()
    @nameEditor.on 'core:cancel', => @detach()
