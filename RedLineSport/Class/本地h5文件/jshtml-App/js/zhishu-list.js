$(document).ready(function(){
      init(); 
    });
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
	 bridge.registerHandler('zhishulist', function(data, responseCallback) {
			var responseData = { 'Javascript Says':'Right back atcha!' }
			
			showpage(data[0],data[1],data[2],data[3])
			
			})
	 })


 var sid='',flags='';
 var showpage = function(data,flag,sids,companyid){
    init();
	sid=sids;
	flags=flag;
 
    var data1 = eval('('+data+')');
	var json = data1.data;  
	for(var i=0;i < json.detailodds.length; i++) {
		var jsons=json.detailodds[i],nextjson=json.detailodds[i+1];
		var homecolor="",offcolor="",guestcolor="",wincolor="",drawcolor="",losecolor="";  
		 if(flag==4){
		 if(i<json.detailodds.length-1){
			 if(jsons.homewin>nextjson.homewin){
			 jsons.homecolor="red-color"
			}
			if(jsons.homewin<nextjson.homewin){
				 jsons.homecolor="green-color"
				}
			if(jsons.standoff>nextjson.standoff){
				 jsons.offcolor="red-color"
				}
			if(jsons.standoff<nextjson.standoff){
				 jsons.offcolor="green-color"
				}
			if(jsons.guestwin>nextjson.guestwin){
				 jsons.guestcolor="red-color"
				}
			if(jsons.guestwin<nextjson.guestwin){
				 jsons.guestcolor="green-color"
				} 
			 } 
		if(jsons.winKellyIdx>1){
			jsons.wincolor="red-color"
		  }
		 if(jsons.drawKellyIdx>1){
			 jsons.drawcolor="red-color"
		  }
		if(jsons.loseKellyIdx>1){
			 jsons.losecolor="red-color"
			 }
	 }else{ 
	   if(i<json.detailodds.length-1){
		 if(jsons.upodds>nextjson.upodds){
			 jsons.homecolor="red-color"
			}
		if(jsons.upodds<nextjson.upodds){
			 jsons.homecolor="green-color"
			}
		if(jsons.downodds>nextjson.downodds){
			 jsons.guestcolor="red-color"
			}
		if(jsons.downodds<nextjson.downodds){
			 jsons.guestcolor="green-color"
			} 
		} 
		 } 
		jsons.modifytime=new Date(jsons.modifytime.replace(/-/g,"/")).format('MM-dd hh:mm') 
	 }
	  if(json.historySame.winRate!="-"){
			  json.historySame.winRate=json.historySame.winRate+"%"
			 }
		 if(json.historySame.loseRate!="-"){
			  json.historySame.loseRate=json.historySame.loseRate+"%"
			 }
		 if(json.historySame.drawRate!="-"){
			  json.historySame.drawRate=json.historySame.drawRate+"%"
			 }
		 if(json.historyAll.winRate!="-"){
			  json.historyAll.winRate=json.historyAll.winRate+"%"
			 }
		 if(json.historyAll.loseRate!="-"){
			  json.historyAll.loseRate=json.historyAll.loseRate+"%"
			 }
		 if(json.historyAll.drawRate!="-"){
			  json.historyAll.drawRate=json.historyAll.drawRate+"%"
			 } 
		if((json.historySame.matchNum==0&&json.historyAll.matchNum==0)||(companyid!=281&&companyid!=8)){
			 json.see=false
			 }else{ 
			 json.see=true
		  }
		var datas={list:json.detailodds,flag:flag,historySame:json.historySame,historyAll:json.historyAll,see:json.see,count:json.detailodds.length-1}
		console.log(datas)


		$('#zsMacth').next().html(template('zsMacth',datas));
     
     
     $('#btn_submit').click(function(){ 
		setupWebViewJavascriptBridge(function(bridge) {
				 bridge.callHandler('tongpeiList',
									{'sid':sid,'flag':flags
									},
									function responseCallback(responseData) {
									console.log("JS received response:", responseData)
									})
				 })
		
		}); 
      
}


