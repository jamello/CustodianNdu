var myWin;
var iw;
var ih;

var icordX;
var icordY;

var myValue;

// Set the fixed window size.
	var startWindowWidth  = 640;
	var startWindowHeight = 480;
	
	// Set the default start window location.
	var startWindowLeft   = 200;
	var startWindowTop    = 100;
	
	// Set the fade in delay.
	var fadeDelay1		  = 200;
	var fadeDelay2		  = 250;


	
	// Check if the screen size info is available.
	// ok
	//if (window.screen)
	//{
	//	// Calculate the real default window location.
	//	startWindowLeft = (window.screen.availWidth - startWindowWidth) / 2;
	//	startWindowTop  = (window.screen.availHeight - startWindowHeight) / 2;
	//}

	// Center the start window on the screen.
	//window.moveTo(startWindowLeft, startWindowTop);
	//window.resizeTo(startWindowWidth, startWindowHeight);

	//value = "1";
	//document.cookie = name + "=" + escape(value);




	function statbar() {
	    //window.status = "Loading. Please wait...";
	    //setTimeout("statbar()", 10);
	}

function JSDO_RETURN(pURL) {
    try {
        myprm = confirm("*** WARNING: You are About to Close this Page *** " +
         "\n\n\t+++ OK TO CLOSE THIS PAGE ? +++");
        if (myprm == true) {
            window.location.href = pURL;
        }
    }
    catch (ex_err) {
        alert("Error has occured. Reason: " + ex_err.message);
    }
}

function JSDO_LOG_OUT() {

    myprm = confirm("*** DO YOU WANT TO LOG OUT NOW ?");
    if (myprm == true) {
        // window.location.href = pURL;
        document.forms["Form1"].elements["txtAction"].value = "Log_Out";
        document.forms["Form1"].submit();
    }
    else {
        Pcnt = 0;
        //alert("Log Out Cancelled!");
    }
}

	function validateForm(form) {
	    var i;
	    var pass = true;
	    for (i = 0; i < form.length; i++) {
	        var element = form.elements[i];
	        if (element.name.substring(0, 8) == "required") {
	            if (((element.type == "text" || element.type == "textarea") &&
                  element.value == '') && element.selectedIndex == 0) {
	                pass = false;
	                break;
	            }
	        }
	    }
	    if (!pass) {
	        var shortName = element.name.substring(8, 30).toUpperCase();
	        alert("Please complete the " + shortName + " field correctly.");
	        return false;
	    }
	    else {
	        return true;
	    }
	}

	function JavaNew_Rtn() {
	    myValue = confirm("WARNING!. THIS FORM OR PAGE CONTENTS WILL BE CLEARED! \nNOTE: Any unsave data will be discarded. \n\nOK to clear the content of this form or page ?");
	    //alert("User Value: " + myValue);
	    if (myValue == true) {
	        //alert("About to save data into database...");
	        //document.form1.txtAction.value = "new";
	        document.form1.submit;
	    }
	}

	function JavaSave_Rtn() {
	    myValue = confirm("OK to save this record into database ?");
	    //alert("User Value: " + myValue);
	    if (myValue == true) {
	        //alert("About to save data into database...");
	        //document.form1.txtAction.value = "save";
	        document.form1.submit;
	    }
	}

	function JavaDel_Rtn() {
	    myValue = confirm("WARNING. Record will be permanently lost. \nOK to delete this record from database ?");
	    //alert("User Value: " + myValue);
	    if (myValue == true) {
	        //alert("About to delete data from database...");
	        document.form1.txtAction.value = "del";
	        document.form1.submit;
	    }
	}

	function myMsg() {

	    //  using confirm method
	    var myValue = confirm("OK to save data into database ?");
	    if (myValue == false) {
	        alert("You press the cancel button...");
	    }
	    else {
	        alert("Return value for button pressed : " + myValue);
	    }


	    //  using prompt method
	    var myState = prompt("Enter your state", "Kano");
	    if (myState == null) {
	        alert("You press the cancel button...");
	    }
	    else {
	        alert("Your state is : " + myState);
	    }

	}


	function onExitKeyDown()
	{
		if (event.keyCode == 13)
			self.close();
	}
	
	function onExitFocus()
	{
		if (event.altKey)
			self.close();
	}
	
	function onLinkFocus(oLink)
	{
		if (event.altKey)
			oLink.click();
	}

	function onLinkClick(oLink)
	{
		window.focus();
		return true;
	}


// Due to IE security patch KB824145, we can no longer simulate the dragging of the browser window.  
	// This is the next best thing we can do at this moment.
	function startDrag()
	{
		offsetX = event.clientX
		offsetY = event.clientY

		dragApproved = true
	}

	function stopDrag()
	{
		if (dragApproved)
			top.moveBy(event.clientX - offsetX, event.clientY - offsetY);
			
		dragApproved = false;
	}

function onClickLinkApp(sApp) 
	{ 
		var oShell = new ActiveXObject("WScript.Shell"); 
		oShell.Run(sApp); 

//<tr>
//	<td class="normalLink"><a href="#" onclick="onClickLinkApp('.\\setup.exe'); self.close()" tabIndex="3" name="linkRunInstall" onFocus="onLinkFocus(this)" onmouseover="onMouseOver(linkInfoImageRunInstall, L_INFO_RUNINSTALL_VAR_TEXT)" onmouseout="linkInfoFadeOut()"><script language="javascript">document.write(L_LINK_RUNINSTALL_VAR_TEXT)</script></a></td>
//</tr>
//<tr>
//	<td class="normalLink"><a href="#" onclick="onClickLinkApp('.\\setup\\sqlncli.msi'); self.close()" tabIndex="3" name="linkRunSnac" onFocus="onLinkFocus(this)" onmouseover="onMouseOver(linkInfoImageRunInstall, L_INFO_RUNSNAC_VAR_TEXT)" onmouseout="linkInfoFadeOut()"><script language="javascript">document.write(L_LINK_RUNSNAC_VAR_TEXT)</script></a></td>
//</tr>

	}

function windowTitle(sWinMsg)
{
    parent.document.title = sWinMsg;
}

function jsDoPopNewN(PopPage) {

    iw = 850;
    ih = 500;

    icordX = (screen.width - iw) / 2;
    icordY = (screen.height - ih) / 2;
    icordY = ((screen.height - ih) / 2 ) - 50;
        
	myWin = window.open(PopPage, null, "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=0,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	//myWin = window.open(PopPage, "fraDetails", "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=0,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	myWin.focus;

}

function jsDoPopNew_Big(PopPage) {

    iw = 960;
    ih = 500;

    icordX = (screen.width - iw) / 2;
    icordY = (screen.height - ih) / 2;
    icordY = ((screen.height - ih) / 2 ) - 50;
        
	myWin = window.open(PopPage, null, "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=0,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	//myWin = window.open(PopPage, "fraDetails", "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=0,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	myWin.focus;

}


function jsDoPopNew_Full(PopPage) {

    iw = 960;
    ih = 500;

    icordX = (screen.width - iw) / 2;
    icordY = (screen.height - ih) / 2;
    icordY = ((screen.height - ih) / 2 ) - 50;
       
	//myWin = window.open(PopPage, null, "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=0,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	myWin = window.open(PopPage, null, "width=" + iw + ",height=" + ih + ",left=" + icordX + ",top=" + icordY + ",resizable=1,channelmode=1,status=yes,toolbar=no,menubar=no,scrollbars=yes,location=no");
	myWin.focus;

}

function myOpen_Frame(surl) {
    var myurl = null;
    
    if (surl != "") {
        myurl = surl;
        parent.frames["content_frame"].location = myurl;
    }
    else {
        alert("You must pass in valid URL...");
    }

}

function jumpToPage(obj) {
    var url = obj.options[obj.selectedIndex].value;
    if (url == "none") {
        alert("You must select a item from this list...");
    }
    else {
        parent.frames["content_frame"].location = url;
    }
}
