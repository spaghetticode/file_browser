window.FileBrowser or= {}

class FileBrowser.Dom
  @updateModal: ->
    @buildEntryList()
    @updatePath FileBrowser.Path.current

  @buildEntryList: ->
    FileBrowser.Modal.clearList()
    for entry in FileBrowser.Entry.all
      FileBrowser.Modal.list.append(entry.element)

  @handleEntryClick: (entry) ->
      element = entry.element
      element.click ->
       $('.entry').removeClass('selected')
       element.addClass('selected')
       $('#path').val FileBrowser.Path.current + entry.name

  @handleEntryDblClick: (entry) ->
    element = entry.element
    element.dblclick ->
      if entry.type is FileBrowser.Entry.DIRECTORY
        FileBrowser.Path.update entry.name
        FileBrowser.Dom.updatePath FileBrowser.Path.current
      else
        alert entry.type

   @buildEntryElement: (entry) ->
    $(JST['file_browser/templates/file_browser/entry'](entry))

  @updatePath: (path) ->
    $('#path').val path