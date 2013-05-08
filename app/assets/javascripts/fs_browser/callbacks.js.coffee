class FsBrowser.Callbacks
  @entryClick: (event, entry) ->
    console.log "clicked on #{entry.name}"

  @entryDblClick: (event, entry) ->
    console.log "double clicked on file #{entry.name}"

  @modalSubmit: (event) ->
    console.log "clicked 'Open' button"