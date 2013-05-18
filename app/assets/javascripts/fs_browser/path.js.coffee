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
    if @tree.length then @tree.join(@separator) else ''

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