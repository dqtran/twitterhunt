$.ajax({
	url: 'data/timeline.json',
	type: 'GET',
	dataType: 'json',
})

.done(function(data){
	console.log("Success");
		
	for (var i = 1; i <= data.length; i++){				
		var tweet = data[i].text;
		var time = data[i].created_at;
		$('<p />').appendTo('.tweet').html(String(i) + ". " + tweet + ".  <strong>Created at: </strong>"+ time);
	}
});

