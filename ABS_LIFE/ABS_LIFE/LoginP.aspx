<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoginP.aspx.vb" Inherits="LoginP" %>

<%@ Register src="UC_BANP.ascx" tagname="UC_BANP" tagprefix="uc1" %>

<%@ Register src="UC_FOOT.ascx" tagname="UC_FOOT" tagprefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
    <script language="javascript" type="text/javascript" src="Script/ScriptJS.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    //<![CDATA[
      var qsfCurrentDemo;
      var qsfDemoWebServicePath;

      function myTest() {
          //alert("Welcome..." + "\n" + "<%=cmdClose.ClientID%>");
          //document.getElementById('<%=cmdClose.ClientID%>').click();
          //document.getElementById('cmdClose').click();
          //document.getElementById('<%=cmdClose.ClientID%>').fireEvent("onclick");
          
      }

      function myShowDialogue(p1, p2) {
          alert("Hello " + p1 + " " + p2 + "\nThis dialogue has been invoked through codebehind.");
      }       
        
    function myld() {
	var winSize = ",width=" + (screen.availWidth - 200).toString() + ",height=" + (screen.availHeight - 200).toString();

//	var wnd = window.open("", "codeViewer", "status=0,toolbar=0,scrollbars=1,resizable=1" + winSize);
//    wnd.document.open();
//    wnd.document.write("<html><head>");
//    wnd.document.write("");
//    wnd.document.write("</head><body>");
//    //wnd.document.write(codeViewerContents.html());
//    wnd.document.write("Welcome to Customer Support System<hr/>")
//    wnd.document.write("Email:&nbsp;<input type='text' name='txtemail' /> </br />")
//    wnd.document.write("<input type='button' name='butemail' value='Submit...' />  </br />")
//    wnd.document.write("</hr />")
//    wnd.document.write("</body></html>");
//    wnd.document.close();    

	//qsfDemoWebServicePath = '<%= ResolveUrl("~/Common/RatingWebService.asmx") %>';
	//qsfDemoWebServicePath = '<%= ResolveUrl("LoginP.aspx") %>';
    //qsfCurrentDemo = "<%= HttpContext.Current.Request.Url.AbsolutePath.ToLowerInvariant() %>";
    //alert ("Value: " + qsfCurrentDemo + "\n" + qsfDemoWebServicePath )
    }
    
    //]]>
</script>
</head>
<body>

    <form id="Form1" runat="server">
    <!-- start banner -->
    <div id="div_banner" align="center">                
                
        <uc1:UC_BANP ID="UC_BANP1" runat="server" />
                
    </div>
    

    <div =id="div_content" align="center">
        <table class="tbl_cont" align="center">
        <tr>
            <td align="left" valign="top" class="td_menu">
	            <table align="center" border="0" cellspacing="0" class="TBL_LOGIN">
	                <caption>Login Information</caption>
                    <tr>
                        <td align="left" colspan="3">Please Login with your valid User ID and Password</td>
                        <td align="right" colspan="1">Date:&nbsp;<%= dteMydate %>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="4"><hr /></td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="display: none;" colspan="4">&nbsp;<asp:Button ID="cmdHelp" Text="Help..." runat="server" />
                            &nbsp;<asp:Label ID="lblJavaScript" runat="server"></asp:Label>
                            &nbsp;<input type="text" id="Message" /> 
                            &nbsp;<input type="button" value="ClickMe" onclick="DoClick()" />

                        </td>
                    </tr>
                    <tr>
    	                <td colspan="2" rowspan="6" align="center">
    	                    <asp:Image ID="Image1" ImageUrl="~/Images/img4.jpg" runat="server" Height="120px" />
    	                </td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblUser_ID" Text="User ID:" runat="server"></asp:Label>&nbsp;</td>
                        <td><asp:TextBox ID="txtUserID" Enabled="true" AutoPostBack="true" AutoCompleteType="Disabled" runat="server" 
                                Width="140px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblUser_PWD" Text="Password:" runat="server"></asp:Label>&nbsp;</td>
                        <td><asp:TextBox ID="txtUser_PWD" Enabled="true" AutoCompleteType="Disabled" TextMode="Password" 
                                runat="server" Width="140px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblUser_Name" Text="User Name:" runat="server"></asp:Label>&nbsp;</td>
                        <td><asp:TextBox ID="txtUserName" Enabled="false" AutoCompleteType="Disabled"
                                runat="server" Width="230px"></asp:TextBox>&nbsp;</td>
                    </tr>

                    <tr>
                        <td colspan="4"><hr /></td>
                    </tr>
                    <tr>
    	   	            <td align="center" colspan="2">
                	   	    <asp:button id="LoginBtn" Font-Bold="false" Font-Size="Large" Width="100px" runat="server" text="Login..."></asp:button>
    	   	                    &nbsp;&nbsp;&nbsp;<input type="button" id="cmdClose" name="cmdClose" value="Close..." style="font-weight:normal; font-size:large; width:100px;" runat="server"  onclick="javascript:window.close();" />
    	   	            </td>
                    </tr>
                    <!--
                    <tr>
                        <td align="center" colspan="4" valign="top">
                            <a class="HREF_MENU2" href="M_MENU.aspx?menu=HOME">Start Application</a>
                            &nbsp;&nbsp;&nbsp;
                            <a class="HREF_MENU2" href="#" onclick="javascript:window.close();">End Application</a>
                        </td>
                    </tr>
                    -->
                    <tr>
                        <td colspan="4"><hr /></td>
                    </tr>

                    <tr>
                        <td colspan="4"><asp:Label id="lblMessage" runat="server" Font-Size="Medium" ForeColor="Red" Font-Bold="false"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>

            	   	<tr>
    	           	    <td nowrap colspan="4" class="Login_Footer"><%=strCopyRight%></td>
    	   	        </tr>
                </table>
            </td>
        </tr>
        </table>
    </div>


<div  align="center" style="display: none;">
                    <asp:Label ID="Label2" runat="server" Text="File(s): "></asp:Label>
                    <asp:FileUpload ID="RadUpload1" runat="server"  MaxFileInputsCount="2"  OverwriteExistingFiles="false"
                        ControlObjectsVisibility="RemoveButtons" />
                    <asp:Button ID="Button1" runat="server" Text="Save"></asp:Button>
</div>
<div align="center" style="display: none;">
                <div id="UploadedFileLog" runat="server">
                    No uploaded files yet.
                </div>
</div>
                                                                      
<div id="div_footer" align="center">    

    <table id="tbl_footer" align="center">
        <tr>
            <td valign="top">
                <table align="center" border="0" class="footer" style=" background-color: Black;">
                    <tr>
                        <td>
                                
                            <uc2:UC_FOOT ID="UC_FOOT1" runat="server" />
                                
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>    

    </form>
</body>
</html>
