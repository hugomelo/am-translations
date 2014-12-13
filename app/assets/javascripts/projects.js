projects = {
	loadChapter: function() {
		var url = $(this).data('url');
		var content = $(this).next();
		console.log(content.html().trim().length);
		if (content.html().trim().length < 20) {
			content.load(url, function(data){
				content.fadeIn('slow');
			});
		}
		else
			content.slideToggle(1000);
	},

	toggleBlock: function(event) {
		$(this).next().slideToggle();
		event.preventDefault();
	},

	loadAvailableChapters: function(ui) {
		console.log(ui);
		url = $('#translator-chapters').data('url');
		$('#translator-chapters')
			.hide();
		$.post(url, {user_id: ui.item.id}, function(data) {
			$('#translator-chapters').html(data).slideToggle();
		});
	}

};


jQuery(document).ready(function() {
	$('#translator_tokens').on('railsAutocomplete.select', function(event,ui){
		projects.loadAvailableChapters(ui);
	});

	//$('#project #chapters .chapter').on('click', projects.loadChapter);
	//$('#translator_tokens').autocomplete({
		//source: '/users.json',
		//minLength: 2,
		//autoFocus: true
	//});
	//$('#new_invitation h2.action').on('click', projects.toggleBlock);

});

