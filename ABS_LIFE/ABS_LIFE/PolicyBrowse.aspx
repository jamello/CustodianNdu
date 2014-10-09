<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PolicyBrowse.aspx.vb" Inherits="ABS_LIFE.PolicyBrowse" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />  
    <script src="jquery-1.11.0.js" type="text/javascript"></script>


<script language="javascript" type="text/javascript">
    // calling jquery functions once document is ready
    $(document).ready(function() {



    });
    
    function GetRowValue(val) {
        //put the value from the grid selection to an element on the page for onward retrieval
        var txtar = val.split(",");
        document.getElementById("txtValue").value = txtar[0];
        document.getElementById("txtDesc").value = txtar[1];
        document.getElementById("txtValue1").value = txtar[2];
        document.getElementById("txtDesc1").value = txtar[3];
        document.getElementById("txtDesc2").value = txtar[4];
    }
</script>

    <title></title>
</head>
<body>
    <form id="frmPolicyNoSearch" runat="server">
    <div id="cont" class="dataBrowser">
<div id= "PolicyNoSearch">
      <div class="gridp">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Policy List </h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->       
<div>
    <table class="datatable">
    <tr>
        <td>Search</td>
        <td>

        <asp:DropDownList ID="cmbSearchPolicy" runat="server">
                <asp:ListItem Value="0">Select</asp:ListItem>
                <asp:ListItem Value="All">All</asp:ListItem>
                <asp:ListItem Value="Policy">Policy No</asp:ListItem>
                <asp:ListItem Value="Proposal">Proposal No</asp:ListItem>
            </asp:DropDownList>

        </td>
        <td><asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><asp:Button ID="butGO" runat="server" Text="GO" Width="30px" Height="30px" />
        </td>
    <td></td></tr>
    </table>
    
</div>
<asp:GridView ID="grdView"  runat="server"  AutoGenerateColumns="False" 
        DataSourceID="ods1" AllowSorting="True" AllowPaging="True" CssClass="datatable"  
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7"  FirstPageText="«" LastPageText="»" />      
            <Columns>
                <asp:TemplateField>
                    <AlternatingItemTemplate>
                    <asp:Button ID="butSelect" runat="server" Height="20px" Width="20px" />
                    </AlternatingItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="butSelect" runat="server" Height="20px" Width="20px"  />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="sPolicyNumber" HeaderText="Policy #" HeaderStyle-CssClass="first" ItemStyle-CssClass="first" />
                <asp:BoundField DataField="sInsuredName" HeaderText="Insured Name"/>
                <asp:BoundField DataField="sProposalNumber" HeaderText="Proposal #" HeaderStyle-CssClass="first" ItemStyle-CssClass="first" />
                <asp:BoundField DataField="sProductCode" HeaderText="ProductCode"/>
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
 
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="GetPolicyList" TypeName="CustodianLife.Data.ReceiptsRepository" >
             <SelectParameters>
                 <asp:ControlParameter ControlID="cmbSearchPolicy" Name="_key" 
                     PropertyName="SelectedValue" Type="String" />
                 <asp:ControlParameter ControlID="txtSearch" Name="_value" PropertyName="Text" 
                     Type="String" />
             </SelectParameters>
    </asp:ObjectDataSource>  
          
    </div>    
    
    <div>
    <asp:TextBox runat="server" ID="txtValue" CssClass="popupOffset" ></asp:TextBox>
    <asp:TextBox runat="server" ID="txtDesc" CssClass="popupOffset" ></asp:TextBox>
    <asp:TextBox runat="server" ID="txtValue1" CssClass="popupOffset"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtDesc1" CssClass="popupOffset"></asp:TextBox>
    <asp:TextBox runat="server" ID="txtDesc2" CssClass="popupOffset"></asp:TextBox>
    
    </div>
    </div>
    </form>
</body>
</html>
