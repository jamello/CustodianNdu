<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReceiptOthersList.aspx.vb" Inherits="ABS_LIFE.ReceiptOthersList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
    
    <title>Data Entries Listing</title>
</head>
<body>
    <form id="frmReceiptsList" runat="server">
   <div  class="newpage">
      <div class="gridp">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Data Entries Listing</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->
<div id="fram">
    <table class="datatable"><tr><td>Search</td><td><asp:DropDownList ID="cmbSearch" runat="server">
    <asp:ListItem Value="0">Select</asp:ListItem>
    <asp:ListItem Value="All">All</asp:ListItem>
    <asp:ListItem Value="BatchNo">Batch No</asp:ListItem>
    <asp:ListItem Value="BatchDate">Batch Date</asp:ListItem>
    <asp:ListItem Value="TDate">Trans Date</asp:ListItem>
    <asp:ListItem Value="Code">Receipt No</asp:ListItem>
    </asp:DropDownList>
    <asp:DropDownList ID="cmbDirection" runat="server">
    <asp:ListItem Value="0">Select</asp:ListItem>
    <asp:ListItem Value="Begin">Beginning Only</asp:ListItem>
    <asp:ListItem Value="Between">Anywhere</asp:ListItem>
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
        DataSourceID="ods1" AllowSorting="True" CssClass="datatable"
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
            <Columns>
            
              <asp:HyperLinkField DataTextField="glId" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Id" Visible="false"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>

              <asp:HyperLinkField DataTextField="CompanyCode" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Coy"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>
         
         
              <asp:HyperLinkField DataTextField="BatchNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Bat. #"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
         
<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>
         
              <asp:HyperLinkField DataTextField="BatchDate" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Bat. Dt"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >


<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>

              <asp:HyperLinkField DataTextField="SerialNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="SN"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >

<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>

   <asp:HyperLinkField DataTextField="SubSerialNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
         DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5} &prgKey={6}" HeaderText="SSN"  Visible="false" 
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >

<HeaderStyle CssClass="first"></HeaderStyle>

<ItemStyle CssClass="first"></ItemStyle>
                </asp:HyperLinkField>


                <asp:BoundField DataField="DocNo" HeaderText="Recpt No"/>
                <asp:BoundField DataField="TransDate" HeaderText="Trans Date"/>
                <asp:BoundField DataField="ClientName" HeaderText="Payee Name"/>
                <asp:BoundField DataField="TransDescription" HeaderText="Description"/>
                <asp:BoundField DataField="TransType" HeaderText="Type"/>
                <asp:BoundField DataField="GLAmountLC" HeaderText="Amount" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
       
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="GetById" 
           TypeName="CustodianLife.Data.GLTransRepository">
             <SelectParameters>
                 <asp:ControlParameter ControlID="cmbSearch" Name="_key" 
                     PropertyName="SelectedValue" Type="String" />
                 <asp:ControlParameter ControlID="txtSearch" Name="_value" PropertyName="Text" 
                     Type="String" />
                 <asp:ControlParameter ControlID="txtProgType" Name="_prg" PropertyName="Text" 
                     Type="String" />
                 <asp:ControlParameter ControlID="cmbDirection" Name="_searchDirection" PropertyName="Text" 
                     Type="String" DefaultValue="0" />

                     
             </SelectParameters>
    </asp:ObjectDataSource>  
    </div>
    <asp:TextBox runat="server" ID="txtProgType" CssClass="popupOffset"> </asp:TextBox>   

    </form>
</body>
</html>
