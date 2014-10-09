<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_LOAN_INT_RT.aspx.vb" Inherits="ABS_LIFE.PRG_LI_LOAN_INT_RT" %>

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
    <form id="PRG_LI_LOAN_INT_RT" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Loan Interest Rates</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Loan Code</td>
					<td><asp:Dropdownlist ID="cmbLoanCodeID" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Start Loan Amount</td>
					<td><asp:TextBox ID="txtStartLoanAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End Loan Amount</td>
					<td><asp:TextBox ID="txtEndLoanAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Interest Rate</td>
					<td><asp:TextBox ID="txtInterestRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Interest Rate Per</td>
					<td><asp:TextBox ID="txtInterestRatePer" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Loan Interest </h2>
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
            
              <asp:HyperLinkField DataTextField="biId" DataNavigateUrlFields="biId,LoanCode"
         DataNavigateUrlFormatString="~/PRG_LI_LOAN_INT_RT.aspx?idd={0},{1}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="LoanCode" HeaderText="LoanCode" SortExpression="LoanCode" />
                <asp:BoundField DataField="StartLoanAmount" HeaderText="StartLoanAmount" SortExpression="StartLoanAmount" />
                <asp:BoundField DataField="EndLoanAmount" HeaderText="EndLoanAmount" SortExpression="EndLoanAmount" />
                <asp:BoundField DataField="LoanInterestRate" HeaderText="Interest Rate" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="LoanInterestRates" TypeName="CustodianLife.Data.LoanInterestRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
