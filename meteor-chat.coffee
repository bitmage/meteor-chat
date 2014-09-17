root = if (typeof global) is 'object' then global else window

root.ChatHistory = new Meteor.Collection 'history'

if Meteor.isClient
  Meteor.startup ->
    React.renderComponent Main(), document.getElementById 'main'

if Meteor.isServer
  Meteor.startup ->

    # insert history records for testing purposes
    ChatHistory.remove {}
