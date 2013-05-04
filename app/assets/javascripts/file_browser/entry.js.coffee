window.FileBrowser or= {}

class FileBrowser.Entry
  @FILE      = 'file'
  @DIRECTORY = 'directory'
  @FLASH     = ['flv', 'swf']
  @VIDEO     = ['mov', 'avi', 'wmv', 'mp4', 'mkv', 'm4v']
  @AUDIO     = ['mp3', 'ogg', 'wav', 'cue', 'm4a']
  @IMAGE     = ['png', 'jpg', 'jpeg', 'gif', 'bmp']
  @KNOWN     = ['rb', 'js', 'css', 'pdf', 'php', 'ppt', 'psd', 'txt', 'zip', 'doc', 'exe', 'xls', 'java']

  @all: []

  @build: (json) ->
    @all = []
    @all.push(new @ entry) for entry in json



  constructor: (json) ->
    @name    = json.name
    @type    = json.type
    @ext     = json.ext
    @icon    = @_getIcon()
    @element = @_buildElement()
    @_bindClick()
    @_bindDblClick()

  isFile:      -> @type is @constructor.FILE
  isDirectory: -> @type is @constructor.DIRECTORY
  extChars:    -> if @ext then @ext[1..] else 'unk'

  _getIcon: -> "/assets/file_browser/file_icons/#{@_iconName()}.png"

  _iconName: ->
    return 'folder'    if @isDirectory()
    return 'audio'     if @_inArray('AUDIO')
    return 'video'     if @_inArray('VIDEO')
    return 'image'     if @_inArray('IMAGE')
    return 'flash'     if @_inArray('FLASH')
    return @extChars() if @_inArray('KNOWN')
    'file'

  _inArray: (name) ->
    @constructor[name].indexOf(@extChars()) >= 0

  _bindClick: -> FileBrowser.Dom.handleEntryClick(@)

  _bindDblClick: -> FileBrowser.Dom.handleEntryDblClick(@)

  _buildElement: -> FileBrowser.Dom.buildEntryElement(@)
