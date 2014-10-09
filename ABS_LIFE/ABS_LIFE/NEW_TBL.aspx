<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NEW_TBL.aspx.vb" Inherits="NEW_TBL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
    <script language="javascript" type="text/javascript" src="Script/ScriptJS.js">
    </script>
</head>

<body>
    <form id="Form1" name="Form1" runat="server">

    <!-- start banner -->
    <div id="div_banner" align="center">                      
        PACE YOUR BANNER HERE        
    </div>
    
        <!-- start header -->
    <div id="div_header" align="center">
        <a class="HREF_LINK2" href="#">Returns to Previous Page</a>
    </div>

    <!-- start content -->    
    <div id="div_content" align="center">
                    <table class="tbl_cont" align="center">
                        <caption>CAPTION TITLE HERE</caption>
                            <tr>
                                <td align="left" valign="top" class="td_menu">
                                    <table align="center" border="0" cellspacing="0" class="tbl_menu_new">
                                            <tr>
                                                <td align="center" colspan="4" valign="top">
                                                    <asp:button id="cmdNew_ASP" Font-Bold="true" Font-Size="Large" runat="server" text="New Data" OnClientClick="JSNew_ASP();"></asp:button>
                                                    &nbsp;&nbsp;<asp:button id="cmdSave_ASP" Font-Bold="true" Font-Size="Large" runat="server" text="Save Data" OnClientClick="JSSave_ASP();"></asp:button>
                                                    &nbsp;&nbsp;<asp:button id="cmdDelete_ASP" Font-Bold="true" Font-Size="Large" runat="server" text="Delete Data" OnClientClick="JSDelete_ASP();"></asp:button>
                                                    &nbsp;&nbsp;<asp:button id="cmdPrint_ASP" Enabled="false" Font-Bold="true" Font-Size="Large" runat="server" text="Print"></asp:button>
                                                    &nbsp;&nbsp;Status:&nbsp;<asp:textbox id="txtAction" Visible="true" ForeColor="Gray" runat="server" EnableViewState="False" Width="50px"></asp:textbox>
                                                    <!-- &nbsp;&nbsp;<a href="javascript:window.close();">Close...</a> -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="4" valign="top"><hr /></td>
                                            </tr>

                                            <tr>
                                                <td align="left" colspan="4" valign="top" class="myMenu_Title">PAGE TITLE GOES HERE</td>
                                            </tr>
                                            <tr>
                                                <td align="left" valign="top"><asp:Label ID="Label1" Text="Lable Caption 1:" runat="server"></asp:Label></td>
                                                <td align="left" valign="top"><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                                                <td align="left" valign="top"><asp:Label ID="Label2" Text="Lable Caption 2:" runat="server"></asp:Label></td>
                                                <td align="left" valign="top"><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <tr>
                                                <td align="left" valign="top"><asp:Label ID="Label3" Text="Scheme Type:" runat="server"></asp:Label></td>
                                                <td align="left" valign="top" colspan="3">
                                                    <select id="selScheme_Type" class="selScheme" runat="server" onchange="getSelected_Change(this, 'this.forms(0).elements[10]', 'Form1')">
                                                        <option value="*">select option</option>
                                                        <option value="001">Scheme A</option>
                                                        <option value="002">Scheme B</option>
                                                    </select>
                                                    &nbsp;<asp:TextBox ID="TextBox3" runat="server" Width="42px"></asp:TextBox>&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="left" colspan="4" valign="top">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="4" valign="top">
                                                    <asp:Label ID="lblMsg" ForeColor="Red" Font-Size="Small" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="left" colspan="4" valign="top">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>                
    
    </div>

    <!-- footer -->
    <div id="div_footer" align="center">    

        <table id="tbl_footer" align="center">
            <tr>
                <td valign="top">
                    <table align="center" border="0" class="footer" style=" background-color: Black;">
                        <tr>
                            <td>
                                PLACE FOOTER HERE
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
