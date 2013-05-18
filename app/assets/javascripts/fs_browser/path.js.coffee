class FsBrowser.Path
  @tree = []
  @separator = '/'

  @getJson: =>
    $.ajax
      type:     'POST'
      dataType: 'json'
      url:      '/fs_browser/paths'
      data:     {id: @current()}
      success:  @build

  @current: =>
    if @tree.length then @relativePath() else ''

  @relativePath: ->
    path = @tree.join(@separator)
    if path[0] is '/' then path[1..] else path

  @parent: ->
    @tree.pop()
    @current()

  @build: (json) =>
    @tree.push json.name unless @tree.length
    FsBrowser.Entry.build(json.entries)
    FsBrowser.Modal.update()

  @update: (entryName) ->
    if entryName is '..'
      @parent()
    else
      @tree.push entryName
    @getJson()