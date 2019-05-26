var hidecount=0;
var appweb= function(data2,data4,data5){
    init();
    
//    alert(data5);
	var homename=data4.homeName
	var guestname=data4.guesName
	var homeid=data4.hometeamid
	var guestid=data4.guestteamid 
	teamscore(data5) 
    teamstatics(data2,homename,guestname,homeid,guestid)
    eachname();
    $(".zr-list ul").width(($(document).width()-30)/2)
	$("#hislist span.check i").click(function() {
	var last=$(this).parent().parent().find("b")
	last.removeClass("down").addClass("up")
	$(this).toggleClass("dq")  
	if($(this).hasClass("dq")){  
		$("#hislist #one").hide();
		$("#hislist #two").show(); 
	 }else{  
		$("#hislist #one").show();
		$("#hislist #two").hide();  
	 } 
	}); 
  $("#nearlist span.check i").click(function() {
	var last=$(this).parent().parent().find("b")
	last.removeClass("down").addClass("up")
	$(this).toggleClass("dq") 
	var a=$("#nearlist span.check i.dq").size()
	if(a==1){ 
	   var i=$("#nearlist span.check i.dq").index() 
		if(i==0){
			$("#nearlist #one").hide();
			$("#nearlist #two").show();
			$("#nearlist #three").hide();
			$("#nearlist #four").hide(); 
		 }else if(i==1){ 
			$("#nearlist #one").hide();
			$("#nearlist #two").hide();
			$("#nearlist #three").show();
			$("#nearlist #four").hide();  
		 }
		}else if(a==2){ 
			$("#nearlist #one").hide();
			$("#nearlist #two").hide();
			$("#nearlist #three").hide();
			$("#nearlist #four").show();  
		}else{ 
		$("#nearlist #one").show();
		$("#nearlist #two").hide();
		$("#nearlist #three").hide();
		$("#nearlist #four").hide();  
	 } 
	}) 
  $("#twoTeamlist span.checkcount i").click(function() {
	var last=$(this).parent().parent().find("b")
	last.removeClass("down").addClass("up")
	$(this).addClass("dq");
	$(this).siblings().removeClass("dq");
	var i=$(".checkcount i.dq").index()
	if(i==0){
		$(".five").show();
		$(".ten").hide();
		$(".fifteen").hide(); 
	 }else if(i==1){ 
		$(".five").hide();
		$(".ten").show();
		$(".fifteen").hide(); 
	 }else{ 
		$(".five").hide();
		$(".ten").hide();
		$(".fifteen").show();  
	 } 
	});
  $("#twoTeamlist span.check i").click(function() {
	var last=$(this).parent().parent().find("b")
	last.removeClass("down").addClass("up")
	$(this).toggleClass("dq")
	if($(this).hasClass("dq")){
		$("#twoTeamlist #one").hide();
		$("#twoTeamlist #two").show();
	 }else{ 
		$("#twoTeamlist #one").show();
		$("#twoTeamlist #two").hide();
	 } 
	}); 
	
	$("dd>h3").click(function(e) {
	var last=$(this).find("b")
	if(last.hasClass("down"))
    {
		last.removeClass("down").addClass("up") 
		$(this).siblings(".toggle").hide();
	 }else{
		last.removeClass("up").addClass("down")
		$(this).siblings(".toggle").show();
		 }
   });
	  
		  	
} 
var eachname=function(){
	$('.homename').each(function(){
		 var hl=$(this).text() 
		 if($(window).width()>=414){
		  if(hl.length>6){
			 $(this).text(hl.substring(0,6)+'...');
			  }else{
				$(this).text(hl)
			} 
		  }else if($(window).width()<414&&$(window).width()>=375){
			   if(hl.length>5){
			 $(this).text(hl.substring(0,5)+'...');
			  }else{
				$(this).text(hl)
			} 
			  
		 }else{
			if(hl.length>4){
			 $(this).text(hl.substring(0,4)+'...');
			  }else{
				$(this).text(hl)
			} 
		    }
		  });
	 $('.guestname').each(function(){
		 var hl=$(this).text() 
		  if($(window).width()>=414){
			  if(hl.length>6){
				 $(this).text(hl.substring(0,6)+'...');
				  }else{
					$(this).text(hl)
				} 
		  }else if($(window).width()<414&&$(window).width()>=375){
			 if(hl.length>5){
			 $(this).text(hl.substring(0,5)+'...');
			  }else{
				$(this).text(hl)
			}  
		 }else{
			if(hl.length>4){
			   $(this).text(hl.substring(0,4)+'...');
			}else{
				$(this).text(hl)
				} 
		    }
		  }); 
	
	}  
var teamscore= function(data){	 
     if(data.data.length==0){  
	       hidecount++ 
		   $("#zjtzlist").hide()
		   $('#zjtzMacth').next().html(''); 
		 }else{
				 var list=[]; 
				 var  json= data.data.split('!'); 
				 list.name=json[2];
				 list.hbeforeName="主队对阵前"+json[3]+"名"
				 list.hbeforeWin=json[0].split('^')[0]
				 list.hbeforeDraw=json[0].split('^')[1]
				 list.hbeforeLose=json[0].split('^')[2]
				 list.hafterName="主队对阵后"+json[3]+"名"
				 list.hafterWin=json[0].split('^')[3]
				 list.hafterDraw=json[0].split('^')[4]
				 list.hafterLose=json[0].split('^')[5]
				 list.gbeforeName="客队对阵前"+json[3]+"名"
				 list.gbeforeWin=json[1].split('^')[0]
				 list.gbeforeDraw=json[1].split('^')[1]
				 list.gbeforeLose=json[1].split('^')[2]
				 list.gafterName="客队对阵后"+json[3]+"名"
				 list.gafterWin=json[1].split('^')[3]
				 list.gafterDraw=json[1].split('^')[4]
				 list.gafterLose=json[1].split('^')[5]   
				$('#zjtzMacth').next().html(template('zjtzMacth',list));  
				$("#zjtzlist").show()
		} 
 }
var teamstatics= function(data,homename,guestname,homeid,guestid){
			var data1 = eval('('+data+')');
			var array = data1.data;   
			var TeamStatics=array.recentTeamStatics;
			if(TeamStatics!=undefined){
							//战力 
						var zlhomewin=0,zlhomedraw=0,zlhomelose=0,zlhomejf=0;
						zlhomewin=TeamStatics.htenAll.win;
						zlhomedraw=TeamStatics.htenAll.draw;
						zlhomelose=TeamStatics.htenAll.lost;
						zlhomejf=TeamStatics.htenAll.score;
						$(".zlhomewin").html(zlhomewin);
						$(".zlhomedraw").html(zlhomedraw);
						$(".zlhomelose").html(zlhomelose);
						$(".zlhomejf").html(zlhomejf);
						var zlguestwin=0,zlguestdraw=0,zlguestlose=0,zlguestjf=0;
						zlguestwin=TeamStatics.gtenAll.win;
						zlguestdraw=TeamStatics.gtenAll.draw;
						zlguestlose=TeamStatics.gtenAll.lost;
						zlguestjf=TeamStatics.gtenAll.score;
						$(".zlguestwin").html(zlguestwin);
						$(".zlguestdraw").html(zlguestdraw);
						$(".zlguestlose").html(zlguestlose);
						$(".zlguestjf").html(zlguestjf);
						if(zlhomejf==zlguestjf){
							$(".zlwidth").width('50%')
							}else{
								var zlwidth=(zlhomejf/(zlhomejf+zlguestjf))*100+'%';
								$(".zlwidth").width(zlwidth)
						}
						//主客				
						var zkhomewin=0,zkhomedraw=0,zkhomelose=0,zkhomejf=0;
						zkhomewin=TeamStatics.htenHome.win;
						zkhomedraw=TeamStatics.htenHome.draw;
						zkhomelose=TeamStatics.htenHome.lost;
						zkhomejf=TeamStatics.htenHome.score;
						$(".zkhomewin").html(zkhomewin);
						$(".zkhomedraw").html(zkhomedraw);
						$(".zkhomelose").html(zkhomelose);
						$(".zkhomejf").html(zkhomejf); 
						var zkguestwin=0,zkguestdraw=0,zkguestlose=0,zkguestjf=0;
						zkguestwin=TeamStatics.gtenGuest.win;
						zkguestdraw=TeamStatics.gtenGuest.draw;
						zkguestlose=TeamStatics.gtenGuest.lost;
						zkguestjf=TeamStatics.gtenGuest.score;
						$(".zkguestwin").html(zkguestwin);
						$(".zkguestdraw").html(zkguestdraw);
						$(".zkguestlose").html(zkguestlose);
						$(".zkguestjf").html(zkguestjf);
						if(zkhomejf==zkguestjf){
							$(".zkwidth").width('50%')
						}else{
							var zkwidth=(zkhomejf/(zkhomejf+zkguestjf))*100+'%';
							$(".zkwidth").width(zkwidth)
						}
						//攻击
						var gjhomeget=0,gjguestget=0;
						gjhomeget=TeamStatics.htenAll.avgget;
						gjguestget=TeamStatics.gtenAll.avgget; 
						$(".gjhomeget").html(gjhomeget);
						$(".gjguestget").html(gjguestget); 
						if(gjhomeget==gjguestget){
							$(".gjwidth").width('50%')
						}else{
							var gjwidth=(gjhomeget/(gjhomeget+gjguestget))*100+'%';
							$(".gjwidth").width(gjwidth);
						}
						//防守
						var fshomelose=0,fsguestlose=0;
						fshomelose=TeamStatics.htenAll.avgloss; 
						fsguestlose=TeamStatics.gtenAll.avgloss; 
						$(".fshomelose").html(fshomelose);
						$(".fsguestlose").html(fsguestlose); 
						if(fshomelose==fsguestlose){
							$(".fswidth").width('50%')
						}else{
							var fswidth=(fsguestlose/(fshomelose+fsguestlose))*100+'%';
							$(".fswidth").width(fswidth)	
						}	
						
						
						}else{
							$("#zhsl").hide();
							hidecount++
							$(".zlwidth").width('50%')
							$(".zkwidth").width('50%')
							$(".gjwidth").width('50%')
							$(".fswidth").width('50%')
							}
					//赛前指数
					var preMatch=array.preMatchOdds;
					 if(preMatch==undefined||preMatch.company==undefined||preMatch==null){
						  $('#prelist').hide();  
							hidecount++
					      $('#preMatch').next().html('');   
					 }else{   
						 $('#prelist').show();
                         $('#prelist h3 i').text(preMatch.company+'赛前指数');
					     var predata={list:preMatch}   
					    $('#preMatch').next().html(template('preMatch',predata)); 
					 }
							
					//积分排名 
					 var score=array.score;
					if(score==undefined||score.length==0||score.length<0){ 
							hidecount++
						  $('#jfpmlist').hide();  
						  $('#jfpmMacth').next().html('');  
					 }else{    
						if(array.kind==1){   
						  var hScore=[],gScore=[];
						  for(var i=0;i<score.length;i++){
							  if(score[i].name=="主/总"||score[i].name=="主/主"){
								  hScore.push(score[i])
								 }else if (score[i].name=="客/总"||score[i].name=="客/客"){
								  gScore.push(score[i])
							   }
								   
							  }   
						if(gScore.length==0||hScore.length==0){ 
							  $('#jfpmlist').hide();  
							  $('#jfpmMacth').next().html(''); 
						 }else{ 
							    $('#jfpmlist').show();  
							    var jfpmdata={hScore:hScore,gScore:gScore,homename:homename,guestname:guestname,kind:array.kind}   
								console.log(jfpmdata)
								$('#jfpmMacth').next().html(template('jfpmMacth',jfpmdata));
							}
						 }else{ 
							$('#jfpmlist').show();  
							var jfpmdata={score:score,homename:homename,guestname:guestname,kind:array.kind}   
						    console.log(jfpmdata)
							$('#jfpmMacth').next().html(template('jfpmMacth',jfpmdata)); 
						 }
					} 
					//近期战绩
					var nearMatch=array.recentTwoMatch;
					var homeAlllist=nearMatch.homeAll.list;
					var guestAlllist=nearMatch.guestAll.list;
					var homesamelist=nearMatch.home.list;
					var guestsamelist=nearMatch.guest.list;
					var hallSclasslist=nearMatch.homeAllSclass.list;
					var gallSclasslist=nearMatch.guestAllSclass.list;
					var hSclasslist=nearMatch.homeSclass.list;
					var gSclasslist=nearMatch.guestSclass.list; 
				   if(homeAlllist==undefined&&guestAlllist==undefined&&homesamelist==undefined&&guestsamelist==undefined&&hallSclasslist==undefined&&gallSclasslist==undefined&&hSclasslist==undefined&&gSclasslist==undefined){
					   $('#nearlist').hide();
						hidecount++
					   $('#nearMacth').next().html(''); 
					}else{
						$('#nearlist').show(); 
						if(homeAlllist!=undefined){ 
							for(var i = 0;i < homeAlllist.length; i++){
							   var json = homeAlllist[i];  
							   var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color';
								  }else if(pan=='输'){
									 json.pancolor='green-color' 
								 }else{
									 json.pancolor='blue-color' 
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					} 
					   if(guestAlllist!=undefined){ 
						   for(var i = 0;i < guestAlllist.length; i++){
							   var json = guestAlllist[i];
							   var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==guestid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }  
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color';
								}else if(pan=='输'){
									 json.pancolor='green-color'
								 }else{
									 json.pancolor='blue-color'
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					}  
						if(homesamelist!=undefined){ 
							for(var i = 0;i < homesamelist.length; i++){
							   var json = homesamelist[i]; 
							    var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }

							 }   
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color';
								  }else if(pan=='输'){
									 json.pancolor='green-color'
								   }else{
									 json.pancolor='blue-color'
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					} 
					   if(guestsamelist!=undefined){ 
						   for(var i = 0;i < guestsamelist.length; i++){
							   var json = guestsamelist[i];  
							    var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==guestid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }  
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color'; 
								 }else if(pan=='输'){
									 json.pancolor='green-color'
								 }else{
									 json.pancolor='blue-color'
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					}  
					
						if(hallSclasslist!=undefined){ 
							for(var i = 0;i < hallSclasslist.length; i++){
							   var json = hallSclasslist[i];  
							    var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }  
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color'; 
								   }
							   else if(pan=='输'){
									 json.pancolor='green-color' 
								   }
							   else{
									 json.pancolor='blue-color' 
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					} 
					   if(gallSclasslist!=undefined){ 
						   for(var i = 0;i < gallSclasslist.length; i++){
							   var json = gallSclasslist[i];
							   var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==guestid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }    
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color';
								   }
							   else if(pan=='输'){
									 json.pancolor='green-color'
								   }
							   else{
									 json.pancolor='blue-color'
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					}  
						if(hSclasslist!=undefined){ 
							for(var i = 0;i < hSclasslist.length; i++){
							   var json = hSclasslist[i];
							    var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }    
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color'; 
								   }
							   else if(pan=='输'){
									 json.pancolor='green-color' 
								   }
							   else{
									 json.pancolor='blue-color' 
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					} 
					   if(gSclasslist!=undefined){ 
						   for(var i = 0;i < gSclasslist.length; i++){
							   var json = gSclasslist[i]; 
							   var hscore=json.score.split(":")[0];
							   var gscore=json.score.split(":")[1]; 
							   if(json.homeTeamId==guestid){ 
								        if(hscore>gscore){
										   json.homecolor='red-color';
										  }else if(hscore<gscore){
										   json.homecolor='green-color';
										  }else{
										      json.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   json.guestcolor='green-color';
										  }else if(hscore<gscore){
										   json.guestcolor='red-color';
										  }else{
										      json.guestcolor='blue-color';
										  }
							 }   
							   var pan=json.pan; 
							   if(pan=='赢'){
								   json.pancolor='red-color';
								   }
							   else if(pan=='输'){
									 json.pancolor='green-color'
								   }
							   else{
									 json.pancolor='blue-color'
								 } 
								 if(json.dxpan=="大"){
									 json.dxpancolor='red-color'; 
								}else if(json.dxpan=='小'){
									 json.dxpancolor='green-color'; 
								}else{
									 json.dxpancolor='blue-color'; 
									}  
						  }
					}  
					 var neardata={homeAll:nearMatch.homeAll,guestAll:nearMatch.guestAll,home:nearMatch.home,guest:nearMatch.guest,hallSclass:nearMatch.homeAllSclass,gallSclass:nearMatch.guestAllSclass,hSclass:nearMatch.homeSclass,gSclass:nearMatch.guestSclass,homename:homename,guestname:guestname} 
					 $('#nearMacth').next().html(template('nearMacth',neardata)); 
					}
		 
					//历史交锋-全部
					var hisAll = array.historyJiaofengAll; 
					var lists=[],hisimg=[];  
					if(hisAll==undefined||hisAll.length==0){
						 $('#hislist').hide();
							hidecount++
						  $('#hisMacth').next().html(''); 
						}else{
							for(var i = 0;i < hisAll.length; i++)
							{
							 var history = hisAll[i]; 
							 if(i<hisAll.length-1){ 
							   var hscore=history.score.split(":")[0];
							   var gscore=history.score.split(":")[1]; 
							   if(history.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   history.homecolor='red-color';
										  }else if(hscore<gscore){
										   history.homecolor='green-color';
										  }else{
										      history.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   history.guestcolor='green-color';
										  }else if(hscore<gscore){
										   history.guestcolor='red-color';
										  }else{
										      history.guestcolor='blue-color';
										  }
							   }  
								   var pan=history.pan; 
								   if(pan=='赢'){
									   history.pancolor='red-color';  
									   }else if(pan=='输'){
											history.pancolor='green-color';  
									   }else{
											history.pancolor='blue-color';  
										 }
									if(history.dxpan=="大"){
										 history.dxpancolor='red-color'; 
									}else if(history.dxpan=='小'){
										 history.dxpancolor='green-color'; 
									}else{
										 history.dxpancolor='blue-color'; 
										} 
								  lists.push(hisAll[i])
							   }else{
									//历史交锋柱形图	 
									 lswin=history.homewin;
									 lsdraw=history.homedraw;
									 lslost=history.homelost; 
									 hisimg.lswin=lswin;
									 hisimg.lsdraw=lsdraw;
									 hisimg.lslost=lslost;
									 hisimg.spfRate=history.spfRate;
									 hisimg.yaRate=history.yaRate;
									 hisimg.dxRate=history.dxRate;
									 hisimg.totalMatch=history.totalMatch; 
									 var lstotal=lswin+lsdraw+lslost;   
									 hisimg.winrate=(lswin/lstotal)*100
									 hisimg.drawrate=(lsdraw/lstotal)*100
									 hisimg.lostrate=(lslost/lstotal)*100
									 /*var h=($(document).width())/3;
									 var left=(h-50)/2;
									 echartwin(hisimg.winrate,left);
									 echartdraw(hisimg.drawrate,left);
									 echartlost(hisimg.lostrate,left); */  
									 hisimg.winHeight=(lswin/lstotal)*100+'%'
									 hisimg.drawHeight=(lsdraw/lstotal)*100+'%'
									 hisimg.lostHeight=(lslost/lstotal)*100+'%'
									 hisimg.winTop=(17-(lswin/lstotal)*28)+'px'
									 hisimg.drawTop=(17-(lsdraw/lstotal)*28)+'px'
									 hisimg.lostTop=(17-(lslost/lstotal)*28)+'px'
									 
								 }
						}
						var datas={list:lists,hisimg:hisimg} 
						console.log(datas)
						$('#hisMacth').next().html(template('hisMacth',datas)); 
					}
					//历史交锋-主客
					var hisSame = array.historyJiaofengSame; 
					var lists=[],hisimg=[];  
					if(hisSame==undefined||hisSame.length==0){
						 $('#hisSameMacth').next().html(''); 
						}else{
							for(var i = 0;i < hisSame.length; i++)
							{
							 var history = hisSame[i]; 
							 if(i<hisSame.length-1){ 
							   var hscore=history.score.split(":")[0];
							   var gscore=history.score.split(":")[1]; 
							   if(history.homeTeamId==homeid){ 
								        if(hscore>gscore){
										   history.homecolor='red-color';
										  }else if(hscore<gscore){
										   history.homecolor='green-color';
										  }else{
										      history.homecolor='blue-color';
											  }
								   }else{  
								       if(hscore>gscore){
										   history.guestcolor='green-color';
										  }else if(hscore<gscore){
										   history.guestcolor='red-color';
										  }else{
										      history.guestcolor='blue-color';
										  }
							   }  
								   var pan=history.pan; 
								   if(pan=='赢'){
									   history.pancolor='red-color';  
									   }else if(pan=='输'){
											history.pancolor='green-color';  
									   }else{
											history.pancolor='blue-color';  
										 }
									if(history.dxpan=="大"){
										 history.dxpancolor='red-color'; 
									}else if(history.dxpan=='小'){
										 history.dxpancolor='green-color'; 
									}else{
										 history.dxpancolor='blue-color'; 
										} 
								  lists.push(hisSame[i])
							   }else{
									//历史交锋柱形图	 
									 lswin=history.homewin;
									 lsdraw=history.homedraw;
									 lslost=history.homelost; 
									 hisimg.lswin=lswin;
									 hisimg.lsdraw=lsdraw;
									 hisimg.lslost=lslost;
									 hisimg.spfRate=history.spfRate;
									 hisimg.yaRate=history.yaRate;
									 hisimg.dxRate=history.dxRate;
									 hisimg.totalMatch=history.totalNum;
									 var lstotal=lswin+lsdraw+lslost;   
									 hisimg.winrate=(lswin/lstotal)*100
									 hisimg.drawrate=(lsdraw/lstotal)*100
									 hisimg.lostrate=(lslost/lstotal)*100
									 /*var h=($(document).width())/3;
									 var left=(h-50)/2;
									 echartwin1(hisimg.winrate,left);
									 echartdraw1(hisimg.drawrate,left);
									 echartlost1(hisimg.lostrate,left);  */ 
									 hisimg.winHeight=(lswin/lstotal)*100+'%'
									 hisimg.drawHeight=(lsdraw/lstotal)*100+'%'
									 hisimg.lostHeight=(lslost/lstotal)*100+'%'
									 hisimg.winTop=(17-(lswin/lstotal)*28)+'px'
									 hisimg.drawTop=(17-(lsdraw/lstotal)*28)+'px'
									 hisimg.lostTop=(17-(lslost/lstotal)*28)+'px'
									 
								 }
						}
						var datas={list:lists,hisimg:hisimg} 
						console.log(datas)
						$('#hisSameMacth').next().html(template('hisSameMacth',datas)); 
					}
			        //数据对比
					var twoTeam=array.twoTeamStatics;
					if(twoTeam==undefined||twoTeam.length==0){
						$("#twoTeamlist").hide() 
							hidecount++
						$('#twoTeam').next().html('');
					 }else{ 
						$("#twoTeamlist").show(); 
						var twoTeamdata={v:array.twoTeamStatics,homename:homename,guestname:guestname}   
						console.log(twoTeamdata)
						$('#twoTeam').next().html(template('twoTeam',twoTeamdata));
					 }
					 
			        //历史相同指数
					var sameHisTory=array.sameHisToryHandicap;
					if(sameHisTory.guestMatchs.length==0&&sameHisTory.homeMatchs.length==0){
						$("#sameHislist").hide() 
							hidecount++
						$('#sameHisTory').next().html('');
					 }else{ 
						$("#sameHislist").show();
						if(sameHisTory.homeMatchs.length!=0){  
						 for(var i=0;i<sameHisTory.homeMatchs.length;i++){ 
						      var homejson=sameHisTory.homeMatchs[i];
							 var result=homejson.yaResult;
							if(result=="赢"){
								homejson.yacolor='red-color'; 
								if(homejson.homeTeam==sameHisTory.homeTeam){
								   homejson.homecolor='red-color'; 
								 }else{ 
									   homejson.guestcolor='red-color'; 
							     }   
							}else if(result=="输"){
								homejson.yacolor='green-color'; 
								if(homejson.homeTeam==sameHisTory.homeTeam){
								   homejson.homecolor='green-color'; 
								 }else{ 
									   homejson.guestcolor='green-color'; 
							     }   
							}else{
								homejson.yacolor='blue-color'; 
								if(homejson.homeTeam==sameHisTory.homeTeam){
								   homejson.homecolor='blue-color'; 
								 }else{ 
									   homejson.guestcolor='blue-color'; 
							     }   
							 } 
							 
							 }
					 } 
						if(sameHisTory.guestMatchs.length!=0){  
						 for(var i=0;i<sameHisTory.guestMatchs.length;i++){ 
						      var guestjson=sameHisTory.guestMatchs[i];
							 var result=guestjson.yaResult;
							if(result=="赢"){
								guestjson.yacolor='red-color'; 
								if(guestjson.homeTeam==sameHisTory.guestName){
								   guestjson.homecolor='red-color'; 
								 }else{ 
									   guestjson.guestcolor='red-color'; 
							     }   
							}else if(result=="输"){
								guestjson.yacolor='green-color'; 
								if(guestjson.homeTeam==sameHisTory.guestName){
								   guestjson.homecolor='green-color'; 
								 }else{ 
									   guestjson.guestcolor='green-color'; 
							     }   
							}else{
								guestjson.yacolor='blue-color'; 
								if(guestjson.homeTeam==sameHisTory.guestName){
								   guestjson.homecolor='blue-color'; 
								 }else{ 
									   guestjson.guestcolor='blue-color'; 
							     }   
							 } 
					 }
							
					 } 
						console.log(sameHisTory)
						$('#sameHisTory').next().html(template('sameHisTory',sameHisTory));
					 }
					 
					 
					//未来赛事
			        var homefuture=array.homefuturematch;
			        var guestfuture=array.guestfuturematch;
					if(homefuture.length==0&&guestfuture.length==0){ 
						 $('#futurelist').hide()
							hidecount++
						 $('#futureMacth').next().html(''); 
					}else{
						if(homefuture.length>0){ 
							 var size=homefuture.length; 
							 for(var i = 0;i < size; i++){ 
								   var json = homefuture[i];  
								   if(json.homeName==homename){
										   json.homecolor='red-color'; 
									   }else{ 
										   json.guestcolor='red-color'; 
									 }  
								 }
							 }
						
						if(guestfuture.length>0){ 
							 var size=guestfuture.length; 
							 for(var i = 0;i < size; i++){ 
								   var json = guestfuture[i];  
								   if(json.homeName==guestname){
										   json.homecolor='red-color'; 
									   }else{ 
										   json.guestcolor='red-color'; 
									 }  
								 }
							 }
						 var futuredata={hfuture:homefuture,gfuture:guestfuture,homename:homename,guestname:guestname} 
						 console.log(futuredata)
						 $('#futureMacth').next().html(template('futureMacth',futuredata));   
						}
			  //伤停数据 
			        var injure=array.injure
				   if(injure==undefined){ 
						  $('#stList').hide()
							hidecount++
						 $('#stMacth').next().html(''); 
					 }else{   
			             var injurehome=injure.homeinjurestatis,injureguest=injure.guestinjurestatis;
						 var stdata={hstati:injurehome,gstati:injureguest} 
						  console.log(stdata)
						 $('#stMacth').next().html(template('stMacth',stdata));  
					}  
					if(hidecount==10){
						$("#content dl").html('<div class="nodata1"> <img src="img/nodata.png" alt="" /> <span>暂无相关数据</span></div>')
						}
		 
}
 
