
var matchid = '';
$(document).ready(function(){ 
    init();   
 });
//        init JS  //固定写法
window.onerror = function(err) {
    log('window.onerror: ' + err)
}

$(window).scroll(function(){ })

function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}
setupWebViewJavascriptBridge(function(bridge) {
                             
 //JS 注册一个方法  OC 调用
 bridge.registerHandler('zhishu', function(data, responseCallback) {
		var responseData = { 'Javascript Says':'Right back atcha!' } 
		appweb(data[0],data[1],data[2],data[3],data[4]) 
		}) 
 
 bridge.registerHandler('zhishuindex', function(data, responseCallback) {
		var responseData = { 'Javascript Says':'Right back atcha!' } 
		changeIndex(data) 
		})

 
 }) 

var zstableClick = function(){  
    $(".zstable ul li,.zstables ul li").click(function(e) {
	   if($(this).find('span:last-child img').attr("src")=='right.png'){
	   var companyid=$(this).attr("companyid");
	   var oddsid=$(this).attr("oddsid");
	   var flagid=$(this).attr("flag");
	   var companyname=$(this).attr("companyname");  
       setupWebViewJavascriptBridge(function(bridge) {
	   bridge.callHandler('zhushuList',
			  {'companyid':companyid,'oddsid':oddsid,'flagid':flagid,'companyname':companyname,'sid' : matchid,
			  },function responseCallback(responseData) {
			  console.log("JS received response:", responseData)
			  })
	   })
	   }
                           
  });
    
}
 var appweb= function(data1,data2,data3,data4,data5){ 
     init(); 
     showpage(data1);
     showpage1(data2,1);
     showpage1(data3,2);
     showpage2(data4)
     matchid=data5;
     zstableClick() 
     $("#one").show();
     $("#two").hide();
     $("#three").hide();
     $("#four").hide();
     $("#five").hide();  
 } 

var changeIndex = function(index)
{
    $('html,body').animate({'scrollTop':0},300);
    index=parseInt(index)
    if(index==0){
        $("#one").show();
        $("#two").hide();
        $("#three").hide();
        $("#four").hide();
        $("#five").hide();
    }
    if(index==1){
        $("#one").hide();
        $("#two").show();
        $("#three").hide();
        $("#four").hide();
        $("#five").hide();
        
    }
    if(index==2){
        $("#one").hide();
        $("#two").hide();
        $("#three").show();
        $("#four").hide();
        $("#five").hide();
        
    }
    if(index==3){
        $("#one").hide();
        $("#two").hide();
        $("#three").hide(); 
        $("#four").show(); 
        $("#five").hide(); 
        
    }
    if(index==4){
        $("#one").hide();
        $("#two").hide();
        $("#three").hide(); 
        $("#four").hide(); 
        $("#five").show(); 
        
    }
}

var showpage = function(data){
	var data1 = eval('('+data+')');
	var json = data1.data;  
	if(json==undefined||json.length==0){
           var datahtml='<div class="nodata1"> <img src="nodata.png" alt="" /> <span>暂无相关数据</span></div>'
		   $("#one").html(datahtml);   
		   $("#four").html(datahtml);   
	}else{
			var html = '';
			var wid=$(".content").width(); 
			for(var c=0;c<json.length;c++){
				var jsons=json[c]; 
				if(jsons.homewin>jsons.firsthomewin){
					 jsons.homecolor="red-color"
					}
				if(jsons.homewin<jsons.firsthomewin){
					 jsons.homecolor="green-color"
					}
				if(jsons.standoff>jsons.firststandoff){
					 jsons.offcolor="red-color"
					}
				if(jsons.standoff<jsons.firststandoff){
					 jsons.offcolor="green-color"
					}
				if(jsons.guestwin>jsons.firstguestwin){
					 jsons.guestcolor="red-color"
					}
				if(jsons.guestwin<jsons.firstguestwin){
					 jsons.guestcolor="green-color"
					}  
				if(jsons.winKellyIdx>1){
						 jsons.homekellycolor="red-color"
						}
					if(jsons.drawKellyIdx>1){
						 jsons.offkellycolor="red-color"
						}
					if(jsons.loseKellyIdx>1){
						 jsons.guestkellycolor="red-color"
						}
				if(jsons.firstReturnrate!=0&&jsons.returnrate!=0){
					jsons.imgs='<img src="right.png">';
					jsons.firstReturn=(jsons.firstReturnrate*100)+"%"
					jsons.secondReturn=(jsons.returnrate*100)+"%"
				} else{ 
				   jsons.firstReturn='-';
				   jsons.secondReturn='-';
				   jsons.imgs=' ';
				} 
				 jsons.namecss='name';
				if(wid>375){ 
				  if(jsons.company.length>10){
					jsons.namecss='name1'
					}
				 }else{ 
				  if(jsons.company.length>7){
					jsons.namecss='name1'
					}
			 }	  
			   }
			 var list={list:json};   
			 $('#ouMacth').next().html(template('ouMacth',list));
			 $('#klMacth').next().html(template('klMacth',list));  
  } 
}
  var showpage1 = function(data,i){   
		var data1 = eval('('+data+')');
		var json = data1.data; 
		if(json==undefined||json.length==0){
			var datahtml='<div class="nodata1"> <img src="nodata.png" alt="" /> <span>暂无相关数据</span></div>'
			if(i==1){
				$("#two").html(datahtml);    
			}else{
				$("#three").html(datahtml);  
				}
		}else{
			var html = '';	 
			var wid=$(".content").width();
			for(var c=0;c < json.length; c++) {
				var jsons=json[c]; 
				jsons.imgs='<img src="right.png">';
				if(jsons.upodds>jsons.firstupodds){
					jsons.homecolor="red-color"
					}
				if(jsons.upodds<jsons.firstupodds){
					 jsons.homecolor="green-color"
					} 
				if(jsons.downodds>jsons.firstdownodds){
					 jsons.guestcolor="red-color"
					}
				if(jsons.downodds<jsons.firstdownodds){
					 jsons.guestcolor="green-color"
					}   
					jsons.namecss='name';
					if(wid>375){ 
					  if(jsons.company.length>10){
						jsons.namecss='name1'
						}
					 }else{ 
					  if(jsons.company.length>7){
						jsons.namecss='name1'
						}
				 } 
		 }
			var list={list:json}; 
			if(i==1){
			  $('#yaMacth').next().html(template('yaMacth',list));   
			}else{
			$('#dxMacth').next().html(template('dxMacth',list));  
			} 
	} 
}

 var showpage2 = function(data){
	var data1 = eval('('+data+')');
	var json = data1.data;  
	$(".canvas").width($(".content").width()-155)
	$("#canvasDiv1").width($(".canvas").width())
    var left=($(".canvas").width()-130)/2  
	if(json==undefined ||json.bifa.length==0){ 
		var datahtml='<div class="nodata1"> <img src="nodata.png" alt="" /> <span>暂无相关数据</span></div>'
		$("#five").html(datahtml); 
	}else{
			 var bifa=json.bifa; 
		    $('.bifadeal').html(bifa.bifadeal)
			$('.bifadeal').html(bifa.bifadeal);
			$('.bifadealrank').html(bifa.bifadealrank);
			$('.totaldealrank').html(bifa.totaldealrank);
        if(bifa.wintotaldeal.indexOf(',')>-1){
            var winbifa=parseInt(bifa.wintotaldeal.replace(/,/g,''))
        }else{
            var winbifa=parseInt(bifa.wintotaldeal)
							 }
        if(bifa.drawtotaldeal.indexOf(',')>-1){
            var drawbifa=parseInt(bifa.drawtotaldeal.replace(/,/g,''))
        }else{
            var drawbifa=parseInt(bifa.drawtotaldeal)
							 }
        if(bifa.losttotaldeal.indexOf(',')>-1){
            var lostbifa=parseInt(bifa.losttotaldeal.replace(/,/g,''))
        }else{
            var lostbifa=parseInt(bifa.losttotaldeal)
							 } 
        if(winbifa>0&&drawbifa>0){
            if(winbifa>drawbifa){
                $('.wdl1').html('<i class="font-18 red-color">胜<em class="blue-color">平</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="green-color font-18">负</i> <i class="font-11">庄亏选择</i>');
            }else{
                $('.wdl1').html('<i class="font-18 blue-color">平<em class="red-color">胜</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="green-color font-18">负</i> <i class="font-11">庄亏选择</i>');
            }
        }
        if(winbifa>0&&lostbifa>0){
            if(winbifa>lostbifa){
                $('.wdl1').html('<i class="font-18 red-color">胜<em class="green-color">负</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="blue-color font-18">平</i> <i class="font-11">庄亏选择</i>');
            }else{
                $('.wdl1').html('<i class="font-18 green-color">负<em class="red-color">胜</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="blue-color font-18">平</i> <i class="font-11">庄亏选择</i>');
            }
        }
        if(drawbifa>0&&lostbifa>0){
            if(drawbifa>lostbifa){
                $('.wdl1').html('<i class="font-18 blue-color">平<em class="green-color">负</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="red-color font-18">胜</i> <i class="font-11">庄亏选择</i>');
            }else{
                $('.wdl1').html('<i class="font-18 green-color">负<em class="blue-color">平</em></i> <i class="font-11">庄赢选择</i>');
                $('.wdl2').html('<i class="red-color font-18">胜</i> <i class="font-11">庄亏选择</i>');
            }
        }
	  if(winbifa>0&&drawbifa<0&&lostbifa<0){
		  if(drawbifa>lostbifa){
			  $('.wdl1').html('<i class="font-18 red-color">胜</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="blue-color font-18">平<em class="green-color">负</em></i> <i class="font-11">庄亏选择</i>');
		  }else{
			  $('.wdl1').html('<i class="font-18 red-color">胜</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="blue-color font-18">平<em class="green-color">负</em></i> <i class="font-11">庄亏选择</i>');
		  }
	  }
	  if(winbifa<0&&drawbifa>0&&lostbifa<0){
		  if(winbifa>lostbifa){
			  $('.wdl1').html('<i class="font-18 blue-color">平</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="red-color font-18">胜<em class="green-color">负</em></i> <i class="font-11">庄亏选择</i>');
		  }else{
			  $('.wdl1').html('<i class="font-18 blue-color">平</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="green-color font-18">负<em class="red-color">胜</em></i> <i class="font-11">庄亏选择</i>');
		  }
	  }
	  if(winbifa<0&&drawbifa<0&&lostbifa>0){
		  if(winbifa>drawbifa){
			  $('.wdl1').html('<i class="font-18 green-color">负</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="red-color font-18">胜<em class="blue-color">平</em></i> <i class="font-11">庄亏选择</i>');
		  }else{ 
			  $('.wdl1').html('<i class="font-18 green-color">负</i> <i class="font-11">庄赢选择</i>');
			  $('.wdl2').html('<i class="blue-color font-18">平<em class="red-color">胜</em></i> <i class="font-11">庄亏选择</i>');
		  } 
	  }
			 var win_rate=bifa.windealrate.split('%')[0],draw_rate=bifa.drawdealrate.split('%')[0],lost_rate=bifa.lostdealrate.split('%')[0];
			 dealrate(win_rate,draw_rate,lost_rate,left)
			
			bifa.winClass='red-color';
			bifa.drawClass='red-color';
			bifa.lostClass='red-color';
			if(bifa.windealhot<0){
				 bifa.winClass='green-color' 
				}
			if(bifa.drawdealhot<0){
			 bifa.drawClass='green-color' 
			}
			if(bifa.lostdealhot<0){
			 bifa.lostClass='green-color' 
			}
			var  windev=parseInt(bifa.windeviation.split('%')[0]);
			var  drawdev=parseInt(bifa.drawdeviation.split('%')[0]);
			var  lostdev=parseInt(bifa.lostdeviation.split('%')[0]);
			  if(windev>0){ 
				   bifa.windevClass="red-color"
				}
				if(windev<0){
				   bifa.windevClass="green-color"
				} 
				if(drawdev>0){
				   bifa.drawdevClass="red-color"
				}
				if(drawdev<0){
				   bifa.drawdevClass="green-color"
				}
				if(lostdev>0){
				   bifa.lostdevClass="red-color"
				}
				if(lostdev<0){
				   bifa.lostdevClass="green-color"
				}  
		  $('#bfMacth').next().html(template('bfMacth',json.bifa));  	  
		}  
}; 

 var dealrate= function(win_rate,draw_rate,lost_rate,lefts){  
 var  lefts=lefts+65+'px'
 var left=
      // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/pie'  
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('canvasDiv1')); 
                
                var labelWin = {
					normal : {
					    color: '#EA4335',
						label : {
							show : false, 
						},
						labelLine : {
							show : false
						}
					} 
				};  
                var labelPing = {
					normal : {
					    color: '#4285F4',
						label : {
							show : false, 
						},
						labelLine : {
							show : false
						}
					} 
				};  
                var labelLose = {
					normal : {
					    color: '#34A853',
						label : {
							show : false, 
						},
						labelLine : {
							show : false
						}
					} 
				};  
			var radius = ['60px', '65px'];
			option = { 
				toolbox: {
					show : false 
				},
				series : [
					{
						type : 'pie',
						center : [lefts, '75px'],
						radius : radius,
						x: '0', // for funnel 
						startAngle:45,  
						data:[
							{value:win_rate, name:'胜',itemStyle:labelWin},
							{value:draw_rate, name:'平',itemStyle:labelPing},
							{value:lost_rate, name:'负',itemStyle:labelLose}
						]
					}
				], 
				
			}; 
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
};
