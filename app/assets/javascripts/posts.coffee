$ ->
	$('#post_category_id').on 'change', ->
		$.ajax 'update_form',
				type: 'POST',
				data: {
					category_id: $('#post_category_id option:selected').val()
				}
