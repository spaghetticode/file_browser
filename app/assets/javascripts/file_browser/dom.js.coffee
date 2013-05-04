window.FileBrowser or= {}

class FileBrowser.Dom
  @updateModal: ->
    @buildEntryList()
    @updatePath()

  @buildEntryList: ->
    FileBrowser.Modal.clearList()
    for entry in FileBrowser.Entry.all
      FileBrowser.Modal.list.append(entry.element)

  @handleEntryClick: (entry) ->
      element = entry.element
      element.click =>
        $('.entry').removeClass('selected')
        element.addClass('selected')
        @updatePath entry.name

  @handleEntryDblClick: (entry) ->
    element = entry.element
    element.dblclick =>
      if entry.type is FileBrowser.Entry.DIRECTORY
        FileBrowser.Path.update entry.name
        @updatePath()
      else
        alert entry.type

  @buildEntryElement: (entry) ->
    $(JST['file_browser/templates/file_browser/entry'](entry))

  @updatePath: (name) ->
    dirty = [@currentPath(), name].join @separator()
    clean = dirty.replace new RegExp("#{@separator()}#{@separator()}"), @separator()
    $('#path').val clean

  @currentPath: -> FileBrowser.Path.current()
  @separator : -> FileBrowser.Path.separator