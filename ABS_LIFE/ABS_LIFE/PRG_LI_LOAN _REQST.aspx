<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_LOAN _REQST.aspx.vb" Inherits="ABS_LIFE.PRG_LI_LOAN__REQST" %>

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
    <form id="PRG_LI_LOAN_REQST" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Loan Request</h2>
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
					<td>Loan Code</td>
					<td><asp:Dropdownlist ID="cmbLoanCodeID" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Policy Number</td>
					<td><asp:TextBox ID="txtPolicyNo" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Loan Request Date</td>
					<td><asp:TextBox ID="txtLoanRequestDate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Ref. No</td>
					<td><asp:TextBox ID="txtRefNo" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Maximum Amount (Local)</td>
					<td><asp:TextBox ID="txtMaximumAmtLocal" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Maximum Amount (Foreign)</td>
					<td><asp:TextBox ID="txtMaximumAmtForeign" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Loan Amount Granted LC</td>
					<td><asp:TextBox ID="txtAmtGrantedLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Loan Amount Granted FC</td>
					<td><asp:TextBox ID="txtAmtGrantedFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
                <tr>
					<td>Repayment Frequency</td>
					<td><asp:Dropdownlist ID="cmbRepaymentFreq" runat="server" Width="270px">
        				<asp:ListItem Value="0" Text="Loan Repayment Frequency"></asp:ListItem>
        				<asp:ListItem Value="W" Text="Weekly"></asp:ListItem>
        				<asp:ListItem Value="M" Text="Monthly"></asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>				
				<tr>
					<td>No Of Instalment (Repayment)</td>
					<td><asp:TextBox ID="txtRepayNoOfInstal" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
                <tr>
					<td>Start Date (Repayment) </td>
					<td><asp:TextBox ID="txtStartDate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Repayment Amount LC </td>
					<td><asp:TextBox ID="txtRepaymentAmtLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Repayment Amount FC </td>
					<td><asp:TextBox ID="txtRepaymentAmtFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Interest Rate </td>
                    <td><asp:Dropdownlist ID="cmbInterestRate" runat="server" Width="270px">
        				</asp:Dropdownlist></td>				</tr>				
                <tr>
					<td>Loan Interest Amount LC	</td>
					<td><asp:TextBox ID="txtInterestAmtLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Loan Interest Amount FC	</td>
					<td><asp:TextBox ID="txtInterestAmtFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Disbursement Charge LC	</td>
					<td><asp:TextBox ID="txtDisbursementChargeLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>Disbursement Charge FC	</td>
					<td><asp:TextBox ID="txtDisbursementChargeFC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>First Instal. Amt LC	</td>
					<td><asp:TextBox ID="txtFirstInstalAmtLC" runat="server" Width="270px"></asp:TextBox></td>
				</tr>				
                <tr>
					<td>First Instal. Amt FC	</td>
					<td><asp:TextBox ID="txtFirstInstalAmtFC" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Loan Request/Disbursement </h2>
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
            
              <asp:HyperLinkField DataTextField="biId" DataNavigateUrlFields="ldId,ProductCode,LoanCode,PolicyNumber"
         DataNavigateUrlFormatString="~/PRG_LI_LOAN _REQST.aspx?idd={0},{1},{2},{3}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="ProductCode" HeaderText="ProductCode"  Visible=false  />
                <asp:BoundField DataField="LoanCode" HeaderText="LoanCode" Visible=false />
                <asp:BoundField DataField="PolicyNumber" HeaderText="Policy Number" />
                <asp:BoundField DataField="LoanAmtGrantedLC" HeaderText="Amt Granted" />
                <asp:BoundField DataField="LoanInterestAmtLC" HeaderText="Interest Amt" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="LoanDisbursementInfo" TypeName="CustodianLife.Data.LoanDisbursementRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
