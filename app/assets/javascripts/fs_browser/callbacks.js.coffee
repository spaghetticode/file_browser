class FsBrowser.Callbacks
  @entryClick: (entry) ->
    console.log "clicked on #{entry.name}"

  @entryDblClick: (entry) ->
    console.log "double clicked on file #{entry.name}"

  @modalSubmit: (event) ->
    console.log "clicked 'Open' button"