TabRenameView = require './tab-rename-view'
{CompositeDisposable} = require 'atom'

module.exports = TabRename =
  tabRenameView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @tabRenameView = new TabRenameView(state.tabRenameViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @tabRenameView, visible: false)
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add "atom-workspace", "tab-rename:renameClick", => @renameClick()
    @subscriptions.add atom.commands.add "atom-workspace", "tab-rename:renameKeyboard", => @renameKeyboard()
    @subscriptions.add atom.commands.add "atom-workspace", 'core:confirm', => @rename()
    @subscriptions.add atom.commands.add "atom-workspace", 'core:cancel', => @modalPanel.hide()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @tabRenameView.destroy()

  renameClick: ->
    @show()
    @titleElement = @getTitleElement('.tab.right-clicked > .title')

  renameKeyboard: ->
    @show()
    @titleElement = @getTitleElement('.tab.active > .title')

  show: ->
    @modalPanel.show()
    @tabRenameView.nameEditor.setText("")
    @tabRenameView.nameEditor.focus()

  getTitleElement: (locator) ->
    paneView = atom.views.getView(atom.workspace)
    paneView.querySelector(locator)

  rename: ->
    input = @tabRenameView.nameEditor.getText()
    @titleElement.innerText = input if input.length isnt 0
    @modalPanel.hide()
