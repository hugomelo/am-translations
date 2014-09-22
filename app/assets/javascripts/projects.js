function loadChapter() {
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
}

jQuery(document).ready(function() {
	$('#project #chapters .chapter').on('click', loadChapter);
	$('#translator_tokens').tokenInput('/translators.json', { preventDuplicates: true, });
});

