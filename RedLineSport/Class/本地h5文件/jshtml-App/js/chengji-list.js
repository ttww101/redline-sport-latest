 

 var showpage = function(data,datatype){
     var type = datatype.type
	        init();

			var data1 = eval('('+data+')');
			var json = data1.data;    
			if(json!=undefined){ 
			//赛事统计  
			 var datalist={
				 sclass:json.sclassStatis,
				 playYa:json.playYaStatis,
				 playDx:json.playDxStatis,
				 playOu:json.playOuStatis,
				 yastatis:json.yaPanStatis, //亚指统计 
				 dxstatis:json.dxPanStatis,  //进球数盘口统计
				 timestatis:json.timeStatis, //发布时间统计
				 groupMonth:json.groupTimeMonthStatis,//月赛事统计
				 groupWeek:json.groupTimeWeekStatis //每日赛事统计
				 }  
		  }else{ 
			   var datalist={
				 sclass:[],
				 playYa:[],
				 playDx:[],
				 playOu:[],
				 yastatis:[], //亚指统计 
				 dxstatis:[],  //进球数盘口统计
				 timestatis:[], //发布时间统计
				 groupMonth:[],//月赛事统计
				 groupWeek:[] //每日赛事统计
				 } 
				 console.log(datalist)
			  }
			 $('#listMacth').next().html(template('listMacth',datalist)); 
 };
   
