<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_PLAN_MST.aspx.vb" Inherits="ABS_LIFE.PRG_LI_PLAN_MST" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <title>Plan Master Setup</title>
    
    
</head>
<body>
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    <form id="PRG_LI_PLAN_MST" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Plan Master</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Product Code</td>
					<td><asp:Dropdownlist ID="cmbProductCode" runat="server" Width="270px">

        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Plan Code</td>
					<td><asp:TextBox ID="txtPlanCode" runat="server" Width="270px" MaxLength="3"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Term</td>
					<td><asp:TextBox ID="txtPlanTerm" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Plan Minimum Years</td>
					<td><asp:TextBox ID="txtPlanMinYears" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Maximum Years</td>
					<td><asp:TextBox ID="txtPlanMaxYears" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Plan Minimum Age</td>
					<td><asp:TextBox ID="txtPlanMinAge" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Maximum Age</td>
					<td><asp:TextBox ID="txtPlanMaxAge" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Minimum Sum Assured</td>
					<td><asp:TextBox ID="txtPlanMinSA" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Maximum Sum Assured</td>
					<td><asp:TextBox ID="txtPlanMaxSA" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Payment Maturity Based?</td>
                    <td><asp:Dropdownlist ID="cmbPaymentMaturityBased" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Maturity Based?</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>SA Periodic Based?</td>
                    <td><asp:Dropdownlist ID="cmbSAPeriodic" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Periodic Based?</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Payment Surrender Based?</td>
                    <td><asp:Dropdownlist ID="cmbPaymentSurrenderBased" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Payment Surrender Based?</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Maximum No Of Years Before Surrender</td>
					<td><asp:TextBox ID="txtMaxNoOfYrBeforeSurr" runat="server" Width="270px"></asp:TextBox></td>
				</tr>

				<tr>
					<td>Loan Allowed?</td>
					<td><asp:DropDownList ID="cmbLoanAllowed" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Loan Allowed</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
				</asp:DropDownList></td>				</tr>
				<tr>
					<td>Loan % On Sum Assured</td>
					<td><asp:TextBox ID="txtLoanPcentSA" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Minimum Loan Amount</td>
					<td><asp:TextBox ID="txtMinLoanAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Policy Valid After Maturity?</td>
					<td><asp:DropDownList ID="cmbPolicyValidAfterMaturity" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Valid After Maturity?</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
				</asp:DropDownList></td>				</tr>
				<tr>
					<td>Annual Payment Mode Rate</td>
					<td><asp:TextBox ID="txtAnnualPaymentModeRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Half-Yearly Payment Mode Rate</td>
					<td><asp:TextBox ID="txtHalfYrPaymentModeRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Quarterly Payment Mode Rate</td>
					<td><asp:TextBox ID="txtQtrPaymentModeRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Monthly Payment Mode Rate</td>
					<td><asp:TextBox ID="txtMthPaymentModeRate" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Plan Master Listing </h2>
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
                         <asp:HyperLinkField DataTextField="pmId" DataNavigateUrlFields="pmId,ProductCode,PlanCode"
                                 DataNavigateUrlFormatString="~/PRG_LI_PLAN_MST.aspx?idd={0},{1},{2}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                         </asp:HyperLinkField>
                <asp:BoundField DataField="ProductCode" HeaderText="Product" />
                <asp:BoundField DataField="PlanCode" HeaderText="Plan Code" />
                <asp:BoundField DataField="PlanTerm" HeaderText="Plan Term" />
                <asp:BoundField DataField="MinimumYears" HeaderText="Min. Yrs" />
                <asp:BoundField DataField="MaximumYears" HeaderText="Max. Yrs"/>
                <asp:BoundField DataField="MinimumSA" HeaderText="Minimum SA" />
                <asp:BoundField DataField="MaximumSA" HeaderText="Maximum SA" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="PlanMasterInfo" TypeName="CustodianLife.Data.PlanMasterRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
