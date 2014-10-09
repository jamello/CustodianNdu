<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_REQ_ENTRY.aspx.vb" Inherits="ABS_LIFE.PRG_LI_REQ_ENTRY" %>

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
    <form id="PRG_LI_REQ_ENTRY" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Claims Request Entry</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Product System Module</td>
					<td><asp:Dropdownlist ID="cmbPrdSysModule" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">System Module</asp:ListItem>
	                    <asp:ListItem value="I">Individual</asp:ListItem>
	                    <asp:ListItem value="G">Group Life</asp:ListItem>
	                    <asp:ListItem value="A">Annuity</asp:ListItem>

        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Policy Number</td>
					<td><asp:TextBox ID="txtPolicyNo" runat="server" Width="270px" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Claims Number</td>
					<td><asp:TextBox ID="txtClaimsNo" runat="server" Width="270px" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Underwriting Year</td>
					<td><asp:TextBox ID="txtUnderwritingYear" runat="server" Width="270px" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Product Code</td>
					<td><asp:TextBox ID="txtProductCode" runat="server" Width="270px" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Claims Type</td>
					<td><asp:Dropdownlist ID="cmbClaimsType" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">Claims Type</asp:ListItem>
	                    <asp:ListItem value="1">Full Maturity</asp:ListItem>
	                    <asp:ListItem value="2">Partial Maturity</asp:ListItem>
	                    <asp:ListItem value="3">Surrender</asp:ListItem>
	                    <asp:ListItem value="4">Death</asp:ListItem>
	                    <asp:ListItem value="5">Critical Illness</asp:ListItem>
	                    <asp:ListItem value="6">Accident (AFAB)</asp:ListItem>
	                    <asp:ListItem value="7">Paid Up</asp:ListItem>
	                    <asp:ListItem value="8">Partial Withdrawal</asp:ListItem>
	                    <asp:ListItem value="9">Full Withdrawal</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Policy Start Date</td>
					<td><asp:TextBox ID="txtPolicyStartDate" Enabled="false" runat="server" Width="150px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Policy End Date</td>
					<td><asp:TextBox ID="txtPolicyEndDate" Enabled="false" runat="server" Width="150px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Effective Date</td>
					<td><asp:TextBox ID="txtEffectiveDate" Enabled="false" runat="server" Width="150px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Claims Notification Date</td>
					<td><asp:TextBox ID="txtNotificationDate" runat="server" Width="150px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Basic Claims Amount LC</td>
					<td><asp:TextBox ID="txtBasicClaimsAmtLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Basic Claims Amount FC</td>
					<td><asp:TextBox ID="txtBasicClaimsAmtFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Additional Claims Amount LC</td>
					<td><asp:TextBox ID="txtAddClaimsAmtLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Additional Claims Amount FC</td>
					<td><asp:TextBox ID="txtAddClaimsAmtFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Claims Description</td>
					<td><asp:TextBox ID="txtClaimsDescription" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Assured Age</td>
					<td><asp:TextBox ID="txtAssuredAge" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Loss Type Code</td>
					<td><asp:Dropdownlist ID="LossTypeCode" runat="server" Width="270px">
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
                    <h2>Product Details Listing </h2>
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
                         <asp:HyperLinkField DataTextField="pdId" DataNavigateUrlFields="pdId,ProductDetailsModule"
                                 DataNavigateUrlFormatString="~/PRG_LI_PRD_DTL.aspx?idd={0},{1}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
                <asp:BoundField DataField="ProductDetailsModule" HeaderText="Module" />
                <asp:BoundField DataField="ProductCategory" HeaderText="Category" />
                <asp:BoundField DataField="ProductCode" HeaderText="Prod Code" />
                <asp:BoundField DataField="ProductDesc" HeaderText="Product Desc" />
                <asp:BoundField DataField="ProductPlanCode" HeaderText="Plan Code"/>
                <asp:BoundField DataField="ProductAgeCalc" HeaderText="Age Calc" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="ProductDetailInfo" TypeName="CustodianLife.Data.ProductDetailsRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
