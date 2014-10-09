<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_INT_RATE.aspx.vb" Inherits="ABS_LIFE.PRG_LI_INT_RATE" %>

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
    <form id="PRG_LI_INT_RATE" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Interet Rates</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Product Code</td>
					<td><asp:Dropdownlist ID="cmbProductCodeID" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Rate Type</td>
					<td><asp:Dropdownlist ID="cmbRateType" runat="server" Width="270px">
					    
                        <asp:ListItem Text="Contributions" Value="C"> </asp:ListItem>
					    
                        <asp:ListItem Text="Top Up" Value="T"> </asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Start Contribution Amount</td>
					<td><asp:TextBox ID="txtStartContribAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End Contribution Amount</td>
					<td><asp:TextBox ID="txtEndContribAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
                <tr>
					<td>Start Policy Term</td>
					<td><asp:TextBox ID="txtStartPolicyTerm" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End Policy Term</td>
					<td><asp:TextBox ID="txtEndPolicyTerm" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				 <tr>
					<td>Interest Rate</td>
					<td><asp:TextBox ID="txtInterestRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Interest Rate Per</td>
					<td><asp:TextBox ID="txtRatePer" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Rate Start Date</td>
					<td><asp:TextBox ID="txtRateStartDate" runat="server" Width="150px"></asp:TextBox>
                        <script language="JavaScript" type="text/javascript">
                            new tcal({ 'formname': 'PRG_LI_INT_RATE', 'controlname': 'txtRateStartDate' });</script> </td>
				</tr>
				<tr>
					<td>Rate End Date</td>
					<td><asp:TextBox ID="txtRateEndDate" runat="server" Width="150px"></asp:TextBox>
                        <script language="JavaScript" type="text/javascript">
                            new tcal({ 'formname': 'PRG_LI_INT_RATE', 'controlname': 'txtRateEndDate' });</script> </td>
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
                    <h2>Interest Rates </h2>
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
            
              <asp:HyperLinkField DataTextField="irId" DataNavigateUrlFields="irId,ProductCode,RateType"
         DataNavigateUrlFormatString="~/PRG_LI_INT_RATE.aspx?idd={0},{1},{2}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="ProductCode" HeaderText="Product Code"  />
                <asp:BoundField DataField="RateType" HeaderText="Rate Type"  />
                <asp:BoundField DataField="StartTerm" HeaderText="Start Term" />
                <asp:BoundField DataField="EndTerm" HeaderText="End Term" />
                <asp:BoundField DataField="InterestRate" HeaderText="Int. Rate" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="InterestRatesDetails" TypeName="CustodianLife.Data.InterestRatesRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
