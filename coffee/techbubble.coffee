Zepto ->

	$('button#new_game').click ->
		window.bubble = new Bubble($('#bubble'))

	$('button#new_game').trigger('click')

class Bubble
	constructor: (@element) ->
		@element.removeClass()
		@element.removeAttr('style')
		@element.show()

		$('#gameover').hide()

		@available_height = $(window).height()
		@available_width = $(window).width()
		@center()
		@size()

		@scaler = 3

		@bindEvents()

	center: ->
		@element.css("position", "absolute")
		@element.css("top",
			Math.max(0, ((@available_height - @element.height()) / 2) +
				window.pageYOffset) + "px"
		);

		@element.css("left",
			Math.max(0, ((@available_width - @element.width()) / 2) +
				window.pageXOffset)  + "px"
		);

	size: ->
		size = @available_width / 10
		@element.width("#{size}px").height("#{size}px")

	randomSize: ->
		"#{@element.width() + (Math.random() * (@element.width() / @scaler))}px"

	gameDidFinish: ->
		@element.addClass('finished')
		@element.unbind('click').unbind('doubleTap')
		@element.animate({opacity: 0}, 500, 'ease-in', -> 
			$('#gameover').show()
		)

	didGameFinish: ->
		# Game has ended if width is larger than window width
		if @element.width() > @available_width
			@gameDidFinish()

	expand: ->
		size = @randomSize()
		@element.width(size).height(size)
		@center()

		@didGameFinish()

	bindEvents: ->
		@element.click =>
			@expand()
		@element.doubleTap =>
			@expand()
