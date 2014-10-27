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
			        <tr><td>Company Code</td>
			                <td><asp:Dropdownlist ID="cmbCoyCode" runat="server" Width="150px">
        				    </asp:Dropdownlist></td>

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
					    <td><asp:TextBox ID="txtSubCode" runat="server" Width="270px" MaxLength=10 Text="0"></asp:TextBox></td>
					    <td>Sub Description</td>
					    <td><asp:TextBox ID="txtSubDesc" runat="server" Width="270px" MaxLength=150></asp:TextBox></td>

				    </tr>

				    <tr>
					    <td><asp:Label ID="lblLevel" runat="server" Text="Level"> </asp:Label></td>
			                <td><asp:Dropdownlist ID="cmbLevel" runat="server" Width="150px">
        				    <asp:ListItem Value="M" Text="Main Account" Selected="True"> </asp:ListItem>
        				    <asp:ListItem Value="S" Text="Sub Account"> </asp:ListItem>
        				    </asp:Dropdownlist></td>
					    <td><asp:Label ID="lblGroup" runat="server" Text="Group"> </asp:Label></td>
			                <td><asp:Dropdownlist ID="cmbGroup" runat="server" Width="150px">
        				    </asp:Dropdownlist></td>
				    </tr>
				    <tr>
					    <td><asp:Label ID="lblLedgerType" runat="server" Text="Ledger Type" > </asp:Label></td>
					    <td>
                            <asp:DropDownList ID="cmbLedgerType" runat="server" Width = "150px">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem Value="K">Bank</asp:ListItem>
                                    <asp:ListItem Value="L">Liability</asp:ListItem>
                                    <asp:ListItem Value="E">Expenses</asp:ListItem>
                                    <asp:ListItem Value="C">Capital</asp:ListItem>
                                    <asp:ListItem Value="T">Debtors</asp:ListItem>
                                    <asp:ListItem Value="M">Claims</asp:ListItem>
                                    <asp:ListItem Value="F">Fixed Assets</asp:ListItem>
                                    <asp:ListItem Value="G">General Ledger</asp:ListItem>
                                    <asp:ListItem Value="I">Investment</asp:ListItem>
                                    <asp:ListItem Value="S">Stock</asp:ListItem>
                                    <asp:ListItem Value="D">Staff Debtors</asp:ListItem>
                                    <asp:ListItem Value="R">Creditors</asp:ListItem>
                                    <asp:ListItem Value="L">Loans</asp:ListItem>
                                    <asp:ListItem Value="C">Commissions</asp:ListItem>
                                    <asp:ListItem Value="X">Unexpired Risks</asp:ListItem>
                                    <asp:ListItem Value="Y">Claims Outstanding</asp:ListItem>
                                    <asp:ListItem Value="Z">Contigency Reserve</asp:ListItem>
                                </asp:DropDownList>
					    </td>
					    <td></td>
					    <td></td>
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
