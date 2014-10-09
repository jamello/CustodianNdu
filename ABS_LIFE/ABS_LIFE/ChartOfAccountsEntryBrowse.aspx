<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChartOfAccountsEntryBrowse.aspx.vb" Inherits="ABS_LIFE.ChartOfAccountsEntryBrowse" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />  
    <script src="jquery-1.11.0.js" type="text/javascript"></script>

    <script type="text/javascript">

        // calling jquery functions once document is ready
        $(document).ready(function() {
            $("#dtChoose").hide();

            $("#cmbSearch").on('focusout', function(e) {
                e.preventDefault()
                if ($("#cmbSearch").val() == "TDate") {
                    $("#dtChoose").show();
                }
                else {
                    $("#dtChoose").hide();
                }
                return false;
            });

        });
    </script>
    
    <title></title>
</head>
<body>
    <form id="frmReceiptsList" runat="server">
   <div id="fram" class="newpage" >
      <div class="gridp">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Chadrt of Accounts Details </h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->
<div>
    <table class="datatable"><tr><td>Search</td><td><asp:DropDownList ID="cmbSearch" runat="server">
                <asp:ListItem Value="0">Select</asp:ListItem>
                <asp:ListItem Value="All">All</asp:ListItem>
                <asp:ListItem Value="Name">Main Descriptn</asp:ListItem>
                <asp:ListItem Value="Name1">Sub Descriptn</asp:ListItem>
                <asp:ListItem Value="Code">Account Code</asp:ListItem>
                <asp:ListItem Value="SbCode">Sub A/C Code</asp:ListItem>
    </asp:DropDownList>
    </td><td><asp:TextBox ID="txtSearch" runat="server"> </asp:TextBox><span id="dtChoose">                        
    <script language="JavaScript" type="text/javascript">
        new tcal({ 'formname': 'frmReceiptsList', 'controlname': 'txtSearch' });</script> </span><asp:Button ID="butGO" runat="server" Text="Go" Width="35px" Height="35px" /></td><td> 
        <asp:Button
            runat="server" ID="butNew" Text="New" Height="35px"/><asp:Button runat="server" ID="butClose" Text="Close" Height="35px"/>
        </td></tr>
    </table>
    
</div>
       
<asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False" 
        DataSourceID="ods1" AllowSorting="True" CssClass="datatable" PageSize = "10"   AllowPaging="True" 
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
            <Columns>
            
              <asp:HyperLinkField DataTextField="caId" DataNavigateUrlFields="caId,CompanyCode,MainAcctsCode,SubAcctsCode"
                     DataNavigateUrlFormatString="~/PRG_FIN_ACCOUNTS_CHART.aspx?idd={0},{1},{2},{3}" HeaderText="Id"  
                     HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
            <HeaderStyle CssClass="first"></HeaderStyle>

            <ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>
                
              <asp:HyperLinkField DataTextField="MainAcctsCode" DataNavigateUrlFields="caId,CompanyCode,MainAcctsCode,SubAcctsCode"
                     DataNavigateUrlFormatString="~/PRG_FIN_ACCOUNTS_CHART.aspx?idd={0},{1},{2},{3}" HeaderText="Main Code"  
                     HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
            <HeaderStyle CssClass="first"></HeaderStyle>

            <ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>

              <asp:HyperLinkField DataTextField="SubAcctsCode" DataNavigateUrlFields="caId,CompanyCode,MainAcctsCode,SubAcctsCode"
                     DataNavigateUrlFormatString="~/PRG_FIN_ACCOUNTS_CHART.aspx?idd={0},{1},{2},{3}" HeaderText="Sub Code"  
                     HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
            <HeaderStyle CssClass="first"></HeaderStyle>

            <ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>

         
                <asp:BoundField DataField="FullDescription" HeaderText=" Main Description" HeaderStyle-CssClass="first" ItemStyle-CssClass="first" >
                    <HeaderStyle CssClass="first"></HeaderStyle>

                    <ItemStyle CssClass="first"></ItemStyle>
                </asp:BoundField>
                
                <asp:BoundField DataField="ShortDescription" HeaderText="Sub Description"/>
                <asp:BoundField DataField="AccountLedgerType" HeaderText="LTyp"/>
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="GetAccountChartList" TypeName="CustodianLife.Data.AccountsChartRepository" >
             <SelectParameters>
                 <asp:ControlParameter ControlID="cmbSearch" Name="_key" 
                     PropertyName="SelectedValue" Type="String" />
                 <asp:ControlParameter ControlID="txtSearch" Name="_value" PropertyName="Text" 
                     Type="String" />
             </SelectParameters>
    </asp:ObjectDataSource>  
    </div>
    </form>
</body>
</html>
