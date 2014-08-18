/* ****************************************************************** 

	@This javascript Information{
		JS File Name: common.js

		Setting of: General pages
			1:check Browser setting
			2: change image setting
			3: minwith maxwidth setting
			4: onload setting
			5: onresize setting
	}

****************************************************************** */


/*===================================================================
	1:check Browser & OS type
===================================================================*/
function checkUserType(){

	var browserType=new checkBrowserType();
	var osType=new checkOsType();

	function checkBrowserType(){
		this.IE=(navigator.userAgent.indexOf("MSIE")!=-1);
		this.Gecko=(navigator.userAgent.indexOf("Gecko")!=-1);
		this.IE6=(navigator.userAgent.indexOf("MSIE 6.")!=-1);
		this.IE5=(navigator.userAgent.indexOf("MSIE 5.")!=-1);
		this.NC71=(navigator.userAgent.indexOf("Netscape/7.1")!=-1);
		this.NC70=(navigator.userAgent.indexOf("Netscape/7.0")!=-1);
		this.NC6=(navigator.userAgent.indexOf("Netscape/6.")!=-1);
		this.NC7=(navigator.userAgent.indexOf("Netscape/7.")!=-1);
		this.NC4=(navigator.userAgent.indexOf("Netscape/4.")!=-1);
	}
	
	function checkOsType(){
		this.Win=(navigator.appVersion.indexOf("Win")!=-1);
		this.Mac=(navigator.appVersion.indexOf("Mac")!=-1);
		this.Unix=(navigator.appVersion.indexOf("X11")!=-1);
	}


	if(browserType.IE){
		return ("IE");
	}
}


/*===================================================================
	2: change image setting
===================================================================*/

function initRollovers() {
	if (!document.getElementById) return

	var aPreLoad = new Array();
	var sTempSrc;
	var aImages = document.getElementsByTagName('img');

	for (var i = 0; i < aImages.length; i++) {		
		if (aImages[i].className == 'imgover') {
			var src = aImages[i].getAttribute('src');
			var ftype = src.substring(src.lastIndexOf('.'), src.length);
			var hsrc = src.replace(ftype, '_on'+ftype);

			aImages[i].setAttribute('hsrc', hsrc);
			
			aPreLoad[i] = new Image();
			aPreLoad[i].src = hsrc;
			
			aImages[i].onmouseover = function() {
				sTempSrc = this.getAttribute('src');
				this.setAttribute('src', this.getAttribute('hsrc'));
			}	
			
			aImages[i].onmouseout = function() {
				if (!sTempSrc) sTempSrc = this.getAttribute('src').replace('_on'+ftype, ftype);
				this.setAttribute('src', sTempSrc);
			}
		}
	}
}


/*===================================================================
	3: minwith maxwidth setting
===================================================================*/

function setMinMaxWidth() {

	var browserType = checkUserType("browser");
	
	if (!browserType){

		return false;

	} else if( browserType == "IE"){
	
		var windowWidth = document.body.clientWidth;
		var wrapper =document.getElementById("wrapper")
		
		if(!wrapper){
			return false;
		} else{
			if(windowWidth <= 930) {
				document.getElementById("wrapper").style.width = '902px';
			} else {
				document.getElementById("wrapper").style.width = 'auto';
			}
		}
	
	} else{

		return false;
	}

}


/*===================================================================
	4: onload setting
===================================================================*/

window.onload = function() {
	initRollovers();
	setMinMaxWidth();
}


/*===================================================================
	5: onresize setting
===================================================================*/

window.onresize = function() {
	setMinMaxWidth();
}



