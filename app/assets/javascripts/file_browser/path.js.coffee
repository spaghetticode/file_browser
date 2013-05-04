window.FileBrowser or= {}

class FileBrowser.Path
  @tree = []
  @separator = '/'

  @getJson: =>
    $.ajax
      type:     'POST'
      dataType: 'json'
      url:      '/file_browser/paths'
      data:     {id: @current()}
      success:  @build

  @current: =>
    if @tree.length then @tree.join(@separator) else 'root'

  @parent: ->
    @tree.pop()
    @current()

  @build: (json) =>
    @tree.push json.name unless @tree.length
    FileBrowser.Entry.build(json.entries)
    FileBrowser.Dom.updateModal()

  @update: (entryName) ->
    if entryName is '..'
      @parent()
    else
      @tree.push entryName
    @getJson()