# Adapted from https://developers.facebook.com/docs/facebook-login/getting-started-web/
class TT.Views.Facebook extends Backbone.View
  id: 'fb-root'

  initialize: ->
    console.log 'facebook initialize'
    window.fbAsyncInit = =>
      console.log 'fbAsyncInit'
      FB.init {
        appId      : '280017428677873', # App ID
        channelUrl : '//www.triptitude.com/channel.html', # Channel File
        status     : true, # check login status
        cookie     : true, # enable cookies to allow the server to access the session
      }
      FB.getLoginStatus (response) =>
        Backbone.history.start({ pushState: true })
        @authResponseChange response

    id = 'facebook-jssdk'
    unless document.getElementById(id)
      console.log 'adding async facebook tag'
      js = document.createElement('script')
      js.id = id
      js.async = true
      js.src = "//connect.facebook.net/en_US/all.js"
      ref = document.getElementsByTagName('script')[0]
      ref.parentNode.insertBefore(js, ref)

  render: ->
    console.log 'facebook render'
    @

  authResponseChange: (response) =>
    FB.Event.subscribe 'auth.authResponseChange', @authResponseChange
    console.log 'authResponseChange', response
    if (response.status == 'connected')
      # The response object is returned with a status field that lets the app know the current
      # login status of the person. In this case, we're handling the situation where they
      # have logged in to the app.
      FB.api '/me', (response) ->
        user = new Backbone.Model { name: response.name }
        TT.Session.set 'user', user
    else
      # The person is not logged into Facebook, or not logged into the app
      TT.Session.set 'user', null

      # Shame...
      $.fx.off = true
      TT.Navigate '/'
      $.fx.off = false

