root = if (typeof global) is 'object' then global else window

r = React.DOM

root.ChatBox = ReactMeteor.createClass

  getMeteorState: ->
    history: ChatHistory.find().fetch()
    message: ''
    debug: Session.get('debug')
    name: Session.get('name')

  setMessage: (e) ->
    @setState {message: e.target.value}

  sendMessage: ->
    unless @state.message is ''
      ChatHistory.insert {name: @state.name, message: @state.message}
      @setState {message: ''}, =>
        setTimeout @scrollToBottom, 1 # weird, shouldn't have to do this

  scrollToBottom: ->
    pane = @refs.history.getDOMNode()
    pane.scrollTop = pane.scrollHeight

  submitIfEnter: (e) ->
    if e.charCode is 13
      @sendMessage()

  renderChatMessage: (message) ->
    r.span {className: 'chat'}, [
      r.span {className: 'chat-author'}, message.name + ':'
      r.span {className: 'chat-message'}, message.message
    ]

  render: ->
    r.div {className: 'chatbox'}, [
      if @state.debug
        r.pre {className: 'data-preview'},
          r.code {}, JSON.stringify(@state, null, '  ')

      r.div {
        ref: 'history'
        className: 'history'
      }, [
        @renderChatMessage {
          name: 'System'
          message: "Welcome, #{@state.name}!"
        }
      ].concat @state.history.map @renderChatMessage

      r.div {className: 'controls'}, [
        r.input {
          ref: 'chatInput'
          className: 'chat-input'
          onKeyPress: @submitIfEnter
          onChange: @setMessage
          value: @state.message
        }
        r.button {onClick: @sendMessage}, 'Send'
      ]]

  componentDidMount: ->
    @refs.chatInput.getDOMNode().focus()
    @scrollToBottom()

  componentDidUpdate: ->
    @scrollToBottom()
