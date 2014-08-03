tabRenameView = require './tab-rename-view'

module.exports =
  tabRenameView: null

  activate: (state) ->
    @tabRenameView = new tabRenameView(state.tabRenameViewState)

  deactivate: ->
    @tabRenameView.destroy()
