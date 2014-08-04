tabRenameView = require './tab-rename-view'

module.exports =
  tabRenameView: null

  activate: (state) ->
    console.log ("Creating class")
    @tabRenameView = new tabRenameView(state.tabRenameViewState)
    
  deactivate: ->
    @tabRenameView.destroy()
