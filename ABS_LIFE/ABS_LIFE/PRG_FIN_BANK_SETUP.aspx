<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_BANK_SETUP.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_BANK_SETUP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <title></title>
    
    
</head>
<body>
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    <form id="PRG_FIN_BANK_SETUP" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Bank Accounts Setup</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Company Code</td>
                    <td><asp:Dropdownlist ID="cmbCoyCode" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Start Bank Division</td>
                    <td><asp:Dropdownlist ID="cmbStartBankDiv" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>End Bank Division</td>
                    <td><asp:Dropdownlist ID="cmbEndBankDiv" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Start Department</td>
                    <td><asp:Dropdownlist ID="cmbStartDept" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>End Department</td>
                    <td><asp:Dropdownlist ID="cmbEndDept" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Transaction Type</td>
                    <td><asp:Dropdownlist ID="cmbTransType" runat="server" Width="150px">
				        <asp:ListItem Selected="True" Value="0">Transaction Type</asp:ListItem>
	                    <asp:ListItem value="R">Receipt</asp:ListItem>
	                    <asp:ListItem value="P">Payment</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Pay Mode</td>
                    <td><asp:Dropdownlist ID="cmbPayMode" runat="server" Width="150px">
				        <asp:ListItem Selected="True" Value="0">Pay Mode</asp:ListItem>
	                    <asp:ListItem value="Q">Cheque</asp:ListItem>
	                    <asp:ListItem value="T">Transfer</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Our Bank Code</td>
					<td><asp:TextBox ID="txtBankCode" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>GL Main Acct Code</td>
					<td><asp:TextBox ID="txtGLMainAcct" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>GL Sub Acct Code</td>
					<td><asp:TextBox ID="txtGLSubAcct" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Branch</td>
                    <td><asp:Dropdownlist ID="cmbBranch" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td></td><td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" />
                        <asp:Button ID="butDelete" runat="server" Text="Delete"  /></td>
				</tr>
			</table>
			
			                      </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
</div>

<div>
      <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Bank Account Information</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->       
<asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False"
        DataSourceID="ods1" AllowSorting="True" CssClass="datatable"
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
            <Columns>
                         <asp:HyperLinkField DataTextField="baId" DataNavigateUrlFields="baId,CompanyCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_BANK_SETUP.aspx?idd={0},{1}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
                                 
                         <asp:HyperLinkField DataTextField="CompanyCode" DataNavigateUrlFields="baId,CompanyCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_BANK_SETUP.aspx?idd={0},{1}" HeaderText="Coy Code"   
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />

                <asp:BoundField DataField="StartBankDivision" HeaderText="Start Div " />
                <asp:BoundField DataField="StartBankDepartment" HeaderText="Start Start" />
                <asp:BoundField DataField="GLMainAccount" HeaderText="GL Main Acct" />
                <asp:BoundField DataField="BranchCode"  HeaderText="Branch Code" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="BankAccountDetails" TypeName="CustodianLife.Data.BankAccountsRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
