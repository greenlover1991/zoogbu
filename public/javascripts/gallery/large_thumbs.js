/* http://jamesvec.com
   large thumbs v2
   Written by james vecchio (jamesvec[at]gmail.com) June 2010.
   Feel free to use this on any project. 
   I would love to see what people do with it, so drop me a line
   if you use it.
   */

$(document).ready (function(){
//loops to add classes and identifiers
	$('.thumb_desc').each(function(index, element){$(element).attr("class", 'hide');});
    $(".group li a").each(function(index, element){$(element).attr("rel", 'image'+index);});
	
	//variables
	var mainImg = "";
	var showImg = "";
	var contWidth = $('#photo_wrap').width();
	var groups = $('.group').size();
	var totalWidth = groups*contWidth;
	var sectCount = 0;
	
	//slider if needed
	 $('#thumbs').css('width',totalWidth);
	 
	 //if there are more than 6 items scroll
	 if(groups>1){
		 $('#next a').css('display','inline');
		 }
		
		 $('#prev a').click(function(){
                if(sectCount >0){
                    $('#thumbs').animate({left: '+='+contWidth+'px'},{duration: 'slow', easing: 'swing'})
                    sectCount=sectCount-1;
					//if there is no more sections to show hide arrow
                    if(sectCount==groups){
					$('#next a').css('display','none');
					}else{
					$('#next a').css('display','inline');
					}
					if (sectCount ==0) {
					$('#prev a').css('display','none');
					}else{
					$('#prev a').css('display','inline');
					}
               	}
               
                })
            $('#next a').click (function(){
                if(sectCount<groups-1){
                $('#thumbs').animate({left: '-='+contWidth+'px'},{duration: 'slow', easing: 'swing'})
                sectCount = sectCount+1;
					//if there is no more sections to show hide arrow
				   if(sectCount==groups-1){
					$('#next a').css('display','none');
					}else{
					$('#next a').css('display','inline');
					}
					if (sectCount ==0) {
					$('#prev a').css('display','none');
					}else{
					$('#prev a').css('display','inline');
					}
                }
               
                });
		
	 
	
	// hover function SHOW ME DESCRIPTIONS MAN!
	$('.group li').hover (function(){	
								   
		$(this).children('.hide').slideToggle('fast');
	});
	
	
	//click thumbs function MAGIC!
	$('.thumb_img a').click (function(){
	showImg = $(this).attr("href");
	$('.loading').fadeIn('slow', loadImage());
	
	return false;
	function loadImage(){
		var img = new Image;
		$(img).load(function () {
		$('.loading').fadeOut('slow', function(){
			$('#close_msg').fadeTo('slow', 0.5).delay(500).fadeOut('slow');
			});
		$('#large_images').append(this,showImgs());
		}).error(function () {
            // notify the user that the image could not be loaded
        }).attr('src', showImg).addClass('current');
		
	}
	function showImgs(){
		$('#large_images').fadeIn('slow');
		 $('#prev a').fadeOut('slow');
		 $('#next a').fadeOut('slow');
		}
		
		 
		
	});
	
	
	
	//close image function
	$('#large_images').click (function(){
		$(this).fadeOut('slow', function(){
		$('.current').remove();								 
		});
		//see which arrows to display
		 if(sectCount==groups-1){
					$('#next a').css('display','none');
					}else{
					$('#next a').css('display','inline');
					}
					if (sectCount ==0) {
					$('#prev a').css('display','none');
					}else{
					$('#prev a').css('display','inline');
					}
                
		
	});
	
});