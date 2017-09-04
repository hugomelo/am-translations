projects = {
  loadChapter: function() {
    var url = $(this).data('url');
    var content = $(this).next();
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
		url = $('#person-chapters').data('url');
		$('#person-chapters').hide();

		$.post(url, {user_id: chosen.id}, function(data) {
			$('#person-chapters').html(data).slideToggle();
		});
	},

	activateTypeahead: function() {
		var engine = new Bloodhound({
			datumTokenizer: Bloodhound.tokenizers.obj.whitespace('label'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		//prefetch: $('#person_tokens').data('url'),
		remote: $('#person_tokens').data('url')+"?q=%QUERY"
		});

		engine.initialize();

		$('#person_tokens').typeahead(null, {
			name: 'translators',
			displayKey: 'label',
			source: engine.ttAdapter()
		}); 
	},

	cleanupAddPerson: function(event) {
		if (event)
			event.preventDefault();
		$('#person-chapters').slideUp();
		$('#person_tokens').val("");
		$('html, body').animate({ scrollTop: $(".head").offset().top },400);
		return false;
	},

	exportDocument: function() {
		alert("Not implemented yet");
	}

};


jQuery(document).ready(function() {
	$('#person_tokens').on('typeahead:selected', function(event, chosen, name){
		projects.loadAvailableChapters(event, chosen, name);
	});

	$(document).on('click','.cancel-button',projects.cleanupAddPerson);

  if ($("#person_tokens").length)
    projects.activateTypeahead();

	//$('#project #chapters .chapter').on('click', projects.loadChapter);

	$('#new_invitation h4.action').on('click', projects.toggleBlock);
  $(".project .export-project").on("click", projects.exportDocument);
});

