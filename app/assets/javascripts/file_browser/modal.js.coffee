window.FileBrowser or= {}

class FileBrowser.Modal
  @init: (@element) ->
    @list = @element.find('ul')
    @element.modal
      keyboard: true
      show:     false
    @element.on 'show', -> FileBrowser.Path.get()
    @element.modal 'show'

  @clearList: -> @list.html ''