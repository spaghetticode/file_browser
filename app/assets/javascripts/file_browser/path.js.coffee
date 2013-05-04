window.FileBrowser or= {}

class FileBrowser.Path
  @tree = []

  @get: (path='root') =>
    $.ajax
      type:     'POST'
      dataType: 'json'
      url:      '/file_browser/paths'
      data:     {id: path}
      success:  @build

  @build: (json) =>
    @current = json.name
    FileBrowser.Entry.build(json.entries)
    FileBrowser.Dom.updateModal()

  @update: (entryName) ->
    if entryName is '..'
      @tree.pop()
      @current = @tree[@tree.length-1]
    else
      @current = "#{@current}#{entryName}/"
      @tree.push @current
    @get @current