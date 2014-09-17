root = if (typeof global) is 'object' then global else window
r = React.DOM

root.Main = ReactMeteor.createClass

  getMeteorState: ->
    name: Session.get('name')

  render: ->
    if @state.name?
      return ChatBox()

    else
      return Login()
