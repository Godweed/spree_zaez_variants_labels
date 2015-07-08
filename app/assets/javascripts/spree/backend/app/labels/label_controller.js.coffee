class window.LabelController

  constructor: (color) ->
    @color = if color is '' then '#f2f4f8' else color
    do @setElements
    do @defaultExecution
    do @setEvents

  defaultExecution: ->
    @colorPicker.spectrum
      showPaletteOnly: true
      togglePaletteOnly: true
      togglePaletteMoreText: 'Mais'
      togglePaletteLessText: 'Menos'
      color: @color
      palette: [
        ['#1c5e92', '#216da7', '#277bbb', '#2b89cf', '#3096de']
        ['#1d8567', '#239a78', '#28ae88', '#2ec197', '#33d4a8']
        ['#29a2a4', '#2fb6b7', '#35cbcc', '#3bdbdd', '#3ddcde']
        ['#fab702', '#fac016', '#fac633', '#facc4e', '#f9d169']
        ['#ca1527', '#e01b2e', '#df3143', '#e34b5b', '#e56371']
      ]
      change: (tinyColor) =>
        @colorField.val tinyColor.toHexString()

  setElements: ->
    @colorPicker = $ '#colorpicker'
    @colorField = $ '.color-text'

  setEvents: ->
    @colorField.on 'blur', $.proxy(@updateColorPicker, @)


  updateColorPicker: (e) ->
    do e.preventDefault
    @colorPicker.spectrum 'set', e.target.value