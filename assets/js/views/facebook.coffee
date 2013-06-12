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
      }

      # Subscribing to auth.authResponseChange doesn't work on initial load
      # unless someone is signed in, so force a response by calling getLoginStatus,
      # and then subscribing once the call is complete.
      FB.getLoginStatus (response) =>
        @authResponseChange response
        FB.Event.subscribe 'auth.authResponseChange', @authResponseChange

      # On initial page load, parse any facebook tags that are present.
      # Specifically, if the not-logged-in view is active, parse the
      # facebook login button.
      FB.XFBML.parse()

    # Register the Facebook sdk async. window.fbAsyncInit gets called once it's loaded.
    id = 'facebook-jssdk'
    unless document.getElementById(id)
      js = document.createElement('script')
      js.id = id
      js.async = true
      js.src = "//connect.facebook.net/en_US/all.js"
      ref = document.getElementsByTagName('script')[0]
      ref.parentNode.insertBefore(js, ref)

  authResponseChange: (response) =>
    console.log 'Facebook status change:', response.status
    if (response.status == 'connected')
      FB.api '/me', (response) ->
        user = new Backbone.Model(response)
        # We only want 'change:user' to fire if the user is
        # actually different from the the current user.
        currentUser = TT.Session.get('user')
        if currentUser == null or currentUser.get('id') != user.get('id')
          TT.Session.set 'user', user
          $.cookie 'user', user.toJSON()
          console.log 'new user was just set, so redirecting to home'
          TT.Navigate 'home'
    else
      if TT.Session.get('user')
        TT.Session.set 'user', null
        $.removeCookie 'user'
        console.log 'user was just logged ou, so redirecting to root'
        TT.Navigate '', false
        FB.XFBML.parse()
