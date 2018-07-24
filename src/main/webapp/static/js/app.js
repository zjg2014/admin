App = {
    config:{
    	 url:(function(){
             //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
             var curWwwPath=window.document.location.href;
             //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
             var pathName=window.document.location.pathname;
             var pos=curWwwPath.indexOf(pathName);
             //获取主机地址，如： http://localhost:8083
             var localhostPaht=curWwwPath.substring(0,pos);
             //获取带"/"的项目名，如：/uimcardprj
             var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
             return(localhostPaht+projectName);
         }()),
         isLogin:false
    },
    cookie:{
        setCookie:function(c_name,value,expiredays){
        	//debugger;
            var exdate=new Date();
            exdate.setDate(exdate.getDate()+expiredays);
            document.cookie=c_name+ "=" +escape(value)+";path=/"+
                ((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
        },
        getCookie:function(c_name){
            if (document.cookie.length>0)
            {
                c_start=document.cookie.indexOf(c_name + "=");
                if (c_start!=-1)
                {
                    c_start=c_start + c_name.length+1;
                    c_end=document.cookie.indexOf(";",c_start);
                    if (c_end==-1) c_end=document.cookie.length;
                    return unescape(document.cookie.substring(c_start,c_end));
                }
            }
            return "";
        }
    }
};
//easyui combox 实现模糊搜索
$.fn.combobox.defaults.filter = function(q, row){  
    var opts = $(this).combobox('options');  
    return row[opts.textField].indexOf(q) >= 0;  
}  


/**
 * 前端字典处理JS组件，从后台缓存/数据库中查询所有字典数据，然后再浏览器Cookie中保存，
 * HTML中显示字典直接从Cookie中获取获取数据，效率更高。
 * @author TanDong
 * @since 2015-4-23 11:48 create
 * */
//获取所有字典数据
var DictCache = function() {
	if (typeof DictCache.instance === 'object') {
		//console.log("Singleton DictCache from cache !");
		return DictCache.instance;
	}
	DictCache.instance = this;
	this.dictTypes = new Array();
	this.dictItems = new Array();
	this.getDictItemName = getDictItemName;
	this.getDictItems = getDictItems;
	this.getDictItemsDflt = getDictItemsDflt;
	this.getDictItemsDefault = getDictItemsDefault;
	this.getDictItemsCallBack = getDictItemsCallBack;
	this.sync = sync;
	this.dictData = new Object();
	
	//获取字典项名称typeCode：字典类型编码，itemCode：字典项编码
	function getDictItemName(typeCode, itemCode){
		if(this.dictData==null){
			return "";
		}
		var data = this.dictData;
		for(var o in data){
			if(o==typeCode){
				for(var n in data[o]){
					if(data[o][n].itemCode==itemCode){	
						return data[o][n].itemName;
					}
				}
				return itemCode;
			}
			
		}
	}
	
	
	//获取所有字典项typeCode：字典类型编码
	function getDictItems(typeCode, className){
		var ret = new Array();

		if(null == this.dictData){
			return ret;
		}
		ret = this.dictData[typeCode];
		if(className && ret.length > 0){
			var codeResult = [];
			for(var i=0; i<ret.length; i++){
				if(className == ret[i].className){
					codeResult.push(ret[i]);
				}
			}
			return codeResult;
		}
		return ret;
	}
	//获取所有字典项typeCode：字典类型编码 (带默认值：--请选择--)
	function getDictItemsDflt(typeCode , className){
		var ret = new Array();
		var retTem = new Array();
		if(null == this.dictData){
			return ret;
		}
		ret.push({itemCode:'',itemName:'--请选择--'});
		retTem = this.dictData[typeCode];
		for(var i=0;i<retTem.length;i++){
			ret.push(retTem[i]);
		}
		if(className && retTem.length > 0){
			var codeResult = [];
			codeResult.push({itemCode:'',itemName:'--请选择--'});
			for(var i=0; i<retTem.length; i++){
				if(className == retTem[i].className){
					codeResult.push(retTem[i]);
				}
			}
			return codeResult;
		}
		return ret;
	}
	
	//获取所有字典项typeCode：字典类型编码 (带默认值：--全部--)
	function getDictItemsDefault(typeCode , className){
		var ret = new Array();
		var retTem = new Array();
		if(null == this.dictData){
			return ret;
		}
		ret.push({itemCode:'',itemName:'全部'});
		retTem = this.dictData[typeCode];
		for(var i=0;i<retTem.length;i++){
			ret.push(retTem[i]);
		}
		if(className && retTem.length > 0){
			var codeResult = [];
			codeResult.push({itemCode:'',itemName:'全部'});
			for(var i=0; i<retTem.length; i++){
				if(className == retTem[i].className){
					codeResult.push(retTem[i]);
				}
			}
			return codeResult;
		}
		return ret;
	}
	
	//获取所有字典项typeCode：字典类型编码
	function getDictItemsCallBack(typeCode, callback){
		var ret = new Array();
		if(this.dictTypes.length <= 0){
			return ret;
		}
		for(var i=0; i<this.dictTypes.length; i++){
			if(this.dictTypes[i].typeCode != typeCode){
				continue;
			}
			for(var j=0; j<this.dictItems.length; j++){
				if(this.dictItems[j].typeCode != typeCode){
					continue;
				}
				ret.push(this.dictItems[j]);
			}
			break;
		}
		callback({"data":ret});
	}
	
	function sync(url) {
		if (this.dictTypes.length == 0) {
			loadAllDictFromCache(this, url);
		}
	}
};
//字典缓存数据JS对象
var dictCache = new DictCache();
dictCache.sync();


function loadAllDictFromCache(glcache, url) {
	var requestUrl = url;
	if(null == requestUrl || undefined == requestUrl){
		//开发用（本地环境）
//		requestUrl = App.config.url+"/dict/getAllFromCache";
		
		//测试用（开发环境、测试环境、灰度环境、生产环境）
		var curWwwPath=window.document.location.href;
		var pathName=window.document.location.pathname;
		var pos=curWwwPath.indexOf(pathName);
		var localhostPaht=curWwwPath.substring(0,pos);
		requestUrl = localhostPaht+"/sysDictItem/getAllFromCache";
	}
	$.ajax({
		url : requestUrl,
		method : 'post',
		async : false,
		contentType : 'application/json;charset=UTF-8',
		dataType : 'json',
		processData : false,
		success : function(data, textStatus, jqXHR) {
			var ret = eval(data);
			if(ret.success){
				glcache.dictData = ret.obj;
				glcache.dictTypes = ret.obj;
				glcache.dictItems = ret.obj;
				
			}else{
				//console.log("Sync dict from cache has error.");
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			var result = JSON.parse(XMLHttpRequest.responseText);
			//console.log("Sync dict from cache has error :"+result);
		}
	});
}

function loadAllDict(glcache, url) {
	var requestUrl = url;
	if(null == requestUrl || undefined == requestUrl){
		requestUrl = App.config.url+"/sysDictItem/getAllFromCache";
	}
	$.ajax({
		url : requestUrl,
		method : 'post',
		async : false,
		contentType : 'application/json;charset=UTF-8',
		dataType : 'json',
		processData : false,
		success : function(data, textStatus, jqXHR) {
			var ret = eval(data);
			if(ret.success){
				glcache.dictTypes = ret.obj.dictTypes;
				glcache.dictItems = ret.obj.dictItems;
			}else{
				//console.log("Sync dict from cache has error.");
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			var result = JSON.parse(XMLHttpRequest.responseText);
			//console.log("Sync dict from cache has error :"+result);
		}
	});
}


//比较d1是否大于d2
function compareDate(d1,d2)
{
  return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
}

function findItemNameByCodeAndVal(type, val){
	return dictCache.getDictItemName(type,val);
}

/** zx start **/
//可用状态
function formatterUserStatus(val,row){
	return findItemNameByCodeAndVal('user_status',val);
}
//资源类型
function formatterResourceType(val,row){
	return findItemNameByCodeAndVal('resource_type',val);
}
//打开状态
function formatterOpenStatus(val,row){
	return findItemNameByCodeAndVal('open_status',val);
}
//资源打开方式
function formatterOpenMode(val,row){
	return findItemNameByCodeAndVal('open_mode',val);
}
//性别
function formatterSex(val,row){
	return findItemNameByCodeAndVal('sex',val);
}
//用户类型
function formatterUserType(val,row){
	return findItemNameByCodeAndVal('user_type',val);
}

//请求数据字典的combox公用方法
//function findDicforType(typeCode, inputId){
//	$.ajax({  
// 	   type: "POST",  
// 	   url: "../../dict/getDictItems?typeCode="+typeCode,  
// 	   success: function(json){ 
//				var str = '[{"value":"","text":"--"},';
//				for(var o in json.data){
//					 var text = json.data[o].itemName;
//					 var id = json.data[o].itemCode;
//					 var sr = '{"value":"'+id+'","text":"'+text+'" },';
//					 str = str + sr;
//				} 
//				str=str.substring(0,str.length-1);
//				str = str+']';
//
//				var obj = eval('(' + str + ')');
// 	    	 $("#"+inputId).combobox( 'loadData' , obj);
// 	   }  
//    }); 
//}



