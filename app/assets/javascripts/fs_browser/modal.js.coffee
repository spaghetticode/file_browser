window.FsBrowser = {}

class FsBrowser.Modal
  @init: (@element=$('#fs-browser')) ->
    @list   = @element.find('ul')
    @submit = @element.find('button.btn-primary')
    @element.modal
      keyboard: true
      show:     false
    @element.on 'show', =>
      FsBrowser.Path.getJson()
      @submit.off('click.modal_submit').on 'click.modal_submit', =>
        FsBrowser.Callbacks.modalSubmit(event)
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
        FsBrowser.Callbacks.entryClick(event, entry)

  @handleEntryDblClick: (entry) ->
    element = entry.element
    element.dblclick =>
      if entry.type is FsBrowser.Entry.DIRECTORY
        FsBrowser.Path.update entry.name
        @updatePath()
      FsBrowser.Callbacks.entryDblClick(event, entry)

  @buildEntryElement: (entry) ->
    $(JST['fs_browser/templates/fs_browser/entry'](entry))

  @updatePath: (name) ->
    dirty = [@currentPath(), name].join @separator()
    clean = dirty.replace new RegExp("#{@separator()}#{@separator()}"), @separator()
    $('#path').val clean

  @currentPath: -> FsBrowser.Path.current()
  @separator : -> FsBrowser.Path.separator