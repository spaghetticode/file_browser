window.FileBrowser or= {}

class FileBrowser.Modal
  @init: (@element) ->
    @list = @element.find('ul')
    @element.modal
      keyboard: true
      show:     false
    @element.on 'show', -> FileBrowser.Path.getJson()
    @element.modal 'show'

  @clearList: -> @list.html ''