# Adapted from https://developers.facebook.com/docs/facebook-login/getting-started-web/
class TT.Views.Facebook extends Backbone.View
  id: 'fb-root'

  initialize: ->
    window.fbAsyncInit = =>
      FB.init {
        appId      : '280017428677873', # App ID
        channelUrl : '//www.triptitude.com/channel.html', # Channel File
        status     : true, # check login status
        cookie     : true, # enable cookies to allow the server to access the session
        xfbml      : true  # parse XFBML
      }
      FB.Event.subscribe 'auth.authResponseChange', @authResponseChange

   id = 'facebook-jssdk'
   unless document.getElementById(id)
     js = document.createElement('script')
     js.id = id
     js.async = true
     js.src = "//connect.facebook.net/en_US/all.js"
     ref = document.getElementsByTagName('script')[0]
     ref.parentNode.insertBefore(js, ref)

  render: ->
    @

  authResponseChange: (response) ->
    # Here we specify what we do with the response anytime this event occurs.
    if (response.status == 'connected')
      # The response object is returned with a status field that lets the app know the current
      # login status of the person. In this case, we're handling the situation where they
      # have logged in to the app.
      FB.api '/me', (response) ->
        user = new Backbone.Model { name: response.name }
        TT.Session.set 'user', user

    else if (response.status == 'not_authorized')
      # In this case, the person is logged into Facebook, but not into the app, so we call
      # FB.login() to prompt them to do so.
      #FB.login()
      TT.Session.set 'user', null
    else
      # In this case, the person is not logged into Facebook, so we call the login()
      # function to prompt them to do so. Note that at this stage there is no indication
      # of whether they are logged into the app. If they aren't then they'll see the Login
      # dialog right after they log in to Facebook.
      #FB.login()
      TT.Session.set 'user', null
