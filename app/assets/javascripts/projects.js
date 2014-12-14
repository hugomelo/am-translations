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
		$(this).parent().next().slideToggle();
		event.preventDefault();
	},

	loadAvailableChapters: function(event, chosen, name) {
		url = $('#translator-chapters').data('url');
		$('#translator-chapters')
			.hide();
		$.post(url, {user_id: chosen.id}, function(data) {
			$('#translator-chapters').html(data).slideToggle();
		});
	},

	activateTypeahead: function() {
		var engine = new Bloodhound({
			datumTokenizer: Bloodhound.tokenizers.obj.whitespace('label'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		//prefetch: $('#translator_tokens').data('url'),
		remote: $('#translator_tokens').data('url')+"?q=%QUERY"
		});

		engine.initialize();

		$('#translator_tokens').typeahead(null, {
			name: 'translators',
			displayKey: 'label',
			source: engine.ttAdapter()
		}); 
	}

};


jQuery(document).ready(function() {
	$('#translator_tokens').on('typeahead:selected', function(event, chosen, name){
		projects.loadAvailableChapters(event, chosen, name);
	});

	projects.activateTypeahead();

	//$('#project #chapters .chapter').on('click', projects.loadChapter);

	$('#new_invitation h4.action').on('click', projects.toggleBlock);

});

