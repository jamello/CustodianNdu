<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_AGCY_BUDGET.aspx.vb" Inherits="ABS_LIFE.PRG_LI_AGCY_BUDGET" %>

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
 <asp:Label runat=server ID=lblError Font-Bold=true ForeColor=Red Visible=false> </asp:Label>
    <form id="PRG_LI_AGCY_BUDGET" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Agency Production Budget Setup</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Agent Type</td>
					<td><asp:Dropdownlist ID="cmbAgentTypeCode" runat="server" Width="270px">
					    <asp:ListItem Text="Agent Manager" Value="M"> </asp:ListItem>
					    <asp:ListItem Text="Unit manager" Value="U"> </asp:ListItem>
					    <asp:ListItem Text="Existing Agent Under Agency Manager" Value="A"> </asp:ListItem>
					    <asp:ListItem Text="Existing Agent Under Unit Manager" Value="B"> </asp:ListItem>
					    <asp:ListItem Text="New Agents Under Agency Manager" Value="C"> </asp:ListItem>
					    <asp:ListItem Text="New Agents Under Unit Manager" Value="D"> </asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Budget Amount</td>
					<td><asp:TextBox ID="txtBudgetAmount" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Bonus Amount</td>
					<td><asp:TextBox ID="txtBonusAmount" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Start New Agent Month</td>
					<td><asp:TextBox ID="txtStartNewAgentMonth" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End New Agent Month</td>
					<td><asp:TextBox ID="txtEndNewAgentMonth" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Collection Expenses Rate</td>
					<td><asp:TextBox ID="txtCollectionExpRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Additional Collection Expenses Rate</td>
					<td><asp:TextBox ID="txtAddCollectionExpRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Lunch Mode Rate</td>
					<td><asp:TextBox ID="txtLunchModeRate" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Agency Production Budget Details</h2>
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
            
              <asp:HyperLinkField DataTextField="abId" DataNavigateUrlFields="abId,AgencyTypeCode"
         DataNavigateUrlFormatString="~/PRG_LI_AGCY_BUDGET.aspx?idd={0},{1}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="AgencyTypeCode" HeaderText="AgencyTypeCode"/>
                <asp:BoundField DataField="BudgetAmount" HeaderText="Budget Amt"/>
                <asp:BoundField DataField="BonusAmount" HeaderText="Bonus Amt"/>
                <asp:BoundField DataField="CollectionExpensesRate" HeaderText="Col. Exp" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="AgencyProductionBudgetDetails" TypeName="CustodianLife.Data.AgencyProductionBudgetRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
