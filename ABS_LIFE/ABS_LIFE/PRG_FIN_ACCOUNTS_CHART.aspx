<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_ACCOUNTS_CHART.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_ACCOUNTS_CHART" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <script src="jquery-1.11.0.js" type="text/javascript"></script>
    <script src="jquery.simplemodal.js" type="text/javascript"></script>
    <title></title>
    
    
</head>
<body>
  
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    <form id="PRG_FIN_ACCOUNTS_CHART" runat="server">
<div  class="newpage">
    <table>
    <tr>
    <td>
        <asp:Literal runat="server" Visible="false" ID="litMsgs"></asp:Literal>
        <asp:Label runat="server" ID="Status" Font-Bold="true" ForeColor="Red" Visible="true" Text="Status:"> </asp:Label>
        <asp:Label runat="server" ID="Label1" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    </td></tr>
    </table>

     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Accounts Chart Codes</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	

                <table class="tbl_menu_new">
			        <tr><td colspan="4" class="myMenu_Title" align="center"><asp:Label ID="lblDesc1" runat="server" Text="Accounts Chart Setup"> </asp:Label> </td><td></td><td></td><td></td></tr>
			        <tr><td>Company Code</td><td><asp:TextBox ID="txtCompanyCode" runat="server" Width="150px" Enabled="False"></asp:TextBox></td>
					    <td>Entry Date</td>
					
			            <td><asp:TextBox ID="txtEntryDate" runat="server" Width="150px" Enabled="False"></asp:TextBox> </td>
				        <td></td>
                    </tr>
				    <tr>
					    <td>Main Code</td>
					    <td><asp:TextBox ID="txtMainCode" runat="server" Width="270px" MaxLength=15 ></asp:TextBox></td>
					    <td>Main Description</td>
					    <td><asp:TextBox ID="txtMainDesc" runat="server" Width="270px" MaxLength=150></asp:TextBox></td>

				    </tr>
    				
				    <tr>
					    <td>Sub Code</td>
					    <td><asp:TextBox ID="txtSubCode" runat="server" Width="270px" MaxLength=10></asp:TextBox></td>
					    <td>Sub Description</td>
					    <td><asp:TextBox ID="txtSubDesc" runat="server" Width="270px" MaxLength=150></asp:TextBox></td>

				    </tr>

				    <tr>
					    <td><asp:Label ID="lblLevel" runat="server" Text="Level"> </asp:Label></td>
					    <td><asp:TextBox ID="txtLevel" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
					    <td><asp:Label ID="lblGroup" runat="server" Text="Group"> </asp:Label></td>
					    <td><asp:TextBox ID="txtGroup" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
				    </tr>
				    <tr>
					    <td><asp:Label ID="lblLedgCode" runat="server" Text="Ledger Code" > </asp:Label></td>
					    <td><asp:TextBox ID="txtLedgerCode" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
					    <td><asp:Label ID="lblLedgerType" runat="server" Text="Ledger Type"> </asp:Label></td>
					    <td><asp:TextBox ID="txtLedgerType" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
				    </tr>
				    <tr>
					    <td><asp:Label ID="lblSubGrp1" runat="server" Text="Sub Group1"> </asp:Label></td>
					    <td><asp:TextBox ID="txtSubGrp1" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
					    <td><asp:Label ID="lblSubGrp2" runat="server" Text="Sub Group2"> </asp:Label></td>
					    <td><asp:TextBox ID="txtSubGrp2" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
				    </tr>
				    <tr>
					    <td><asp:Label ID="lblProductType" runat="server" Text="Product Code"> </asp:Label></td>
					    <td><asp:TextBox ID="txtProductType" runat="server" Width="150px" MaxLength=25></asp:TextBox></td>
					    <td><asp:Label ID="lblBusType" runat="server" Text="Bus. Type" > </asp:Label></td>
					    <td><asp:TextBox ID="txtBusType" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
				    </tr>
				    <tr>
					    <td><asp:Label ID="lblPolicyType" runat="server" Text="Policy Type"> </asp:Label></td>
					    <td><asp:TextBox ID="txtPolicyType" runat="server" Width="150px" MaxLength=15></asp:TextBox></td>
					    <td><asp:Label ID="lblAccountStatus" runat="server" Text="Account Status" MaxLength=3> </asp:Label></td>
					    <td><asp:TextBox ID="txtAccountStatus" runat="server" Width="150px"></asp:TextBox></td>
				    </tr>
                    <tr>
					    <td><asp:Label ID="lblAccountMode" runat="server" Text="Account Mode"> </asp:Label></td>
					    <td><asp:TextBox ID="txtAccountMode" runat="server" Width="150px" MaxLength=3></asp:TextBox></td>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>    				
				    </tr>
				<tr>
					<td></td><td></td><td></td>
					<td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" />
                        <asp:Button ID="butDelete" runat="server" Text="Delete" style="height: 26px"/>
                        <asp:Button ID="butClose" runat="server" Text="Close" />
                     </td>
				</tr>

			    </table>

			                      </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>

</div> 

		</form>

</body>
</html>
