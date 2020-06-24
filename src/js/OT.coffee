# TB Object:
#   Methods: 
#     TB.checkSystemRequirements() :number
#     TB.initPublisher( apiKey:String [, replaceElementId:String] [, properties:Object] ):Publisher
#     TB.initSession( apiKey, sessionId ):Session 
#     TB.log( message )
#     TB.off( type:String, listener:Function )
#     TB.on( type:String, listener:Function )
#  Methods that doesn't do anything:
#     TB.setLogLevel(logLevel:String)
#     TB.upgradeSystemRequirements()

window.OT =
  timeStreamCreated: {}
  checkSystemRequirements: ->
    return 1
  initPublisher: (one, two) ->
    return new TBPublisher( one, two )
  initSession: (apiKey, sessionId, options) ->
    if( not sessionId? ) then @showError( "OT.initSession accepts 3 parameters, your API Key, Session ID and a optional Session Options object" )
    return new TBSession(apiKey, sessionId, options)
  log: (message) ->
    pdebug "TB LOG", message
  off: (event, handler) ->
    #todo
  on: (event, handler) ->
    if(event=="exception") # TB object only dispatches one type of event
      console.log("JS: TB Exception Handler added")
      Cordova.exec(handler, TBError, OTPlugin, "exceptionHandler", [] )
  setLogLevel: (a) ->
    console.log("Log Level Set")
  upgradeSystemRequirements: ->
    return {}
  updateViews: (containers) ->
    if containers
      for container in containers
        TBUpdateObjects(container)
    else
      TBUpdateObjects()
  # helpers
  getHelper: ->
    if(typeof(jasmine)=="undefined" || !jasmine || !jasmine['getEnv'])
      window.jasmine = {
        getEnv: ->
          return
      }
    this.OTHelper = this.OTHelper || OTHelpers.noConflict()
    return this.OTHelper

  # deprecating
  showError: (a) ->
    alert(a)
  addEventListener: (event, handler) ->
    @on( event, handler )
  removeEventListener: (type, handler ) ->
    @off( type, handler )

window.TB = OT
window.addEventListener "orientationchange", (->
  setTimeout (->
    OT.updateViews()
    return
  ), 1000
  return
), false
document.addEventListener "deviceready", (->
  Cordova.exec(TBSuccess, TBError, OTPlugin, "hasStatusBarPlugin", [window.hasOwnProperty("StatusBar")] )
), false
