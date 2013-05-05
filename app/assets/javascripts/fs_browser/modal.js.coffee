window.FsBrowser = {}

class FsBrowser.Modal
  @init: (@element) ->
    @list = @element.find('ul')
    @element.modal
      keyboard: true
      show:     false
    @element.on 'show', -> FsBrowser.Path.getJson()
    @element.modal 'show'

  @clearList: -> @list.html ''

  @update: ->
    @buildEntryList()
    @updatePath()

  @buildEntryList: ->
    @clearList()
    for entry in FsBrowser.Entry.all
      @list.append(entry.element)

  @handleEntryClick: (entry) ->
      element = entry.element
      element.click =>
        $('.entry').removeClass('selected')
        element.addClass('selected')
        @updatePath entry.name

  @handleEntryDblClick: (entry) ->
    element = entry.element
    element.dblclick =>
      if entry.type is FsBrowser.Entry.DIRECTORY
        FsBrowser.Path.update entry.name
        @updatePath()
      else
        alert entry.type

  @buildEntryElement: (entry) ->
    $(JST['fs_browser/templates/fs_browser/entry'](entry))

  @updatePath: (name) ->
    dirty = [@currentPath(), name].join @separator()
    clean = dirty.replace new RegExp("#{@separator()}#{@separator()}"), @separator()
    $('#path').val clean

  @currentPath: -> FsBrowser.Path.current()
  @separator : -> FsBrowser.Path.separator