root = if (typeof global) is 'object' then global else window
r = React.DOM

root.Login = ReactMeteor.createClass

  getMeteorState: ->
    name: Session.get('name')

  setName: (e) ->
    @setState {name: e.target.value}

  setSessionName: ->
    unless @state.name is ''
      Session.set('name', @state.name)

  submitIfEnter: (e) ->
    if e.charCode is 13
      @setSessionName()

  render: ->
    r.div {className: 'login'}, [
      r.div {}, 'Hello! Please tell us your name before you join the chat.'
      r.input {
        ref: 'loginInput'
        className: 'login-input'
        onChange: @setName
        value: @state.name
        onKeyPress: @submitIfEnter
      }
      r.button {onClick: @setSessionName}, 'Login'
    ]

  componentDidMount: ->
    @refs.loginInput.getDOMNode().focus()
