 

//        init JS  //固定写法
window.onerror = function(err) {
    log('window.onerror: ' + err)
}

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
    bridge.registerHandler('zhiBo', function(data, responseCallback) {
                                                    var responseData = { 'Javascript Says':'Right back atcha!' }
                                                    appweb(data[0],data[1])
                                                    
                                                    })
                             
    bridge.registerHandler('zhiBoindex', function(data, responseCallback) {
                                                    var responseData = { 'Javascript Says':'Right back atcha!' }
                           changindex(data);
                                                    })

                             
                             
                             })


var changindex = function(index)
{
    index = parseInt(index)
    
    if(index==0){
        $("#one").show();
        $("#two").hide();
    } else{
        $("#one").hide();
        $("#two").show();
    }
}
var appweb= function(data1,data2){
    init(); 
    homename=data2.homeName
    guestname=data2.guesName
    showpage(data1,homename,guestname)
}
var showpage = function(data,homename,guestname){ 
	var datas= eval('('+data+')');
	var eventinfo = datas.event; 
	var tech = datas.tech; 
	var events =[]; 	
	if(eventinfo != undefined){
	 for(var a = eventinfo.length-1; a >= 0; --a)
		{  
			events.push(eventinfo[a])
		 }
	 }
	if(tech!=undefined){
		for(var a = 0; a < tech.length; a++)
			{
				var  techs = tech[a]; 
				techs.percent=parseInt(techs.teamA)/(parseInt(techs.teamA)+parseInt(techs.teamB))*100 
		   }  
	 }
	 var data2={event:events,tech:datas.tech}
	 var data1={homestatis:datas.homestatis,gueststatis:datas.gueststatis,homename:homename,guestname:guestname} 
	 $('#zbMacth').next().html(template('zbMacth',data2));
	 $('#zbvsMacth').next().html(template('zbvsMacth',data1));
    $(".zr-list ul").width(($(document).width()-30)/2)
    
	  
	 }   
