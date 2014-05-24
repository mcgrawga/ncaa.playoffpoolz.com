function prep_bracket(){
		//alert("Yo 1");
    $('.team_name').click(function(){
			var title = $(document).attr('title');
			if (title != 'NCAA Tournament Pool - View Bracket' && title != 'NCAA Tournament Pool - View Master Bracket')
		  {	
							var currentHiddenFieldTag = getHiddenFieldTag($(this).attr('id'));
							var nextSpanTag = getNextSpanTag($(this).attr('id'));
							var nextHiddenFieldTag = getHiddenFieldTag(nextSpanTag);

							//alert($(this).text());
							if ( $(this).text() != $("#" + nextSpanTag).text() )
								clearPicks(nextSpanTag, 8); 

							$("#" + nextSpanTag).text($(this).text());
							$("#" + nextHiddenFieldTag).val($("#" + currentHiddenFieldTag).val());
							
							if (nextSpanTag == 'round8_team1')
								$('.nat_champ_team').css({"left":($('.nat_champ_team').parent().width() - $('.nat_champ_team').width()) / 2});
			}
    });

    $('.team_name_rs').click(function(){
			var title = $(document).attr('title');
			//alert(title);
			if (title != 'NCAA Tournament Pool - View Bracket' && title != 'NCAA Tournament Pool - View Master Bracket')
		  {	
							var currentHiddenFieldTag = getHiddenFieldTag($(this).attr('id'));
							var nextSpanTag = getNextSpanTag($(this).attr('id'));
							var nextHiddenFieldTag = getHiddenFieldTag(nextSpanTag);

							if ( $(this).text() != $("#" + nextSpanTag).text() )
								clearPicks(nextSpanTag, 8); 

							$("#" + nextSpanTag).text($(this).text());
							$("#" + nextHiddenFieldTag).val($("#" + currentHiddenFieldTag).val());
							
							if (nextSpanTag == 'round8_team1')
								$('.nat_champ_team').css({"left":($('.nat_champ_team').parent().width() - $('.nat_champ_team').width()) / 2});
			}
    });


		$('.nat_champ_team').each(function(){
				$(this).css({
      	//"position":"relative",
      	"left":($(this).parent().width() - $(this).width()) / 2
    	});
    });

		//alert("Yo 2");
		$('.nat_champ_text').each(function(){
				$(this).css({
      	//"position":"relative",
      	"left":($(this).parent().width() - $(this).width()) / 2
    	});
    });

		var title = $(document).attr('title');
		if (title == 'NCAA Tournament Pool - View Bracket' || title == 'NCAA Tournament Pool - View Master Bracket'){
			$('.column_format').each(function(){
					$(this).css({'cursor' : 'auto'});
    	});
			$('.column_format_rs').each(function(){
					$(this).css({'cursor' : 'auto'});
    	});
			$('.team_name').each(function(){
					$(this).css({'cursor' : 'auto'});
    	});
		}

};


$(document).ready(prep_bracket);
$(document).on('page:load', prep_bracket)

function clearPicks(spanTag, endRound){
    var roundNum = spanTag.charAt(5);
		var teamName = $("#" + spanTag).text();
   	var nextSpanTag = getNextSpanTag(spanTag);
   	var nextHiddenFieldTag = getHiddenFieldTag(nextSpanTag);

		while (roundNum < endRound){
			if ( teamName == $("#" + nextSpanTag).text()	){
				$("#" + nextSpanTag).text('');
				$("#" + nextHiddenFieldTag).val('');
				roundNum = nextSpanTag.charAt(5);
				nextSpanTag = getNextSpanTag(nextSpanTag);
   			nextHiddenFieldTag = getHiddenFieldTag(nextSpanTag);
			}
			else
				break;
		}
}

function getHiddenFieldTag(spanTag){
    var roundNum, teamNum;
    roundNum = spanTag.charAt(5);
    if (spanTag.length == 13) 
        teamNum = spanTag.slice(11);
    else
        teamNum = spanTag.charAt(11);
		var hiddenFieldTag = "bracket_round" + roundNum + "_team" + teamNum;
		return hiddenFieldTag;
}

function getNextSpanTag(spanTag) {
    var roundNum, nextRoundNum, teamNum, nextTeamNum;
    roundNum = spanTag.charAt(5);
    nextRoundNum = (parseInt(roundNum) + 1);

    if (spanTag.length == 13) 
        teamNum = spanTag.slice(11);
    else
        teamNum = spanTag.charAt(11);

    if (teamNum % 2 == 0)
        nextTeamNum = parseInt(teamNum) / 2;
    else
        nextTeamNum = (parseInt(teamNum) + 1) / 2;

    var nextSpanTag = "round" + nextRoundNum + "_team" + nextTeamNum;
    return nextSpanTag;
}
