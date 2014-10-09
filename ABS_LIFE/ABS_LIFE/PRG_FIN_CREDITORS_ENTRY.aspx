<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_CREDITORS_ENTRY.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_CREDITORS_ENTRY" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    
    
   <script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
   <script language="javascript" type="text/javascript" src="Script/ScriptJS.js"></script>	
   
    <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <script src="jquery-1.11.0.js" type="text/javascript"></script>
    <script src="jquery.simplemodal.js" type="text/javascript"></script>
  
    <title></title>
    <script type="text/javascript">
            window.onbeforeunload = confirmExit;
            function confirmExit() {
                window.event.returnValue = 'If you navigate away from this page any unsaved changes will be lost!';
            }

            function cancelEvent(event) {
                window[event] = function () {null}
            } 
        // calling jquery functions once document is ready
        $(document).ready(function() {

            var resultValueDR;
            var resultValueCR;
            var resultValue;
            var resultDesc;
            var resultLedgType;

           // window.onbeforeunload = function(){
           //     return 'All Unsaved Data will be lost! Please Review Again' 
           // }
            
           
              
            function ProductLabels() {
                switch ($('#txtProgType').val()) {
                    case "payment":
                        $('#lblRcptNum').text('Payment No');
                        $('#TellerRow').hide();
                        $('#lblMode').text('Payment Mode');
                        $('#lblRcptDate').text('Payment Date');
                        $('#lblDesc').text('Payments Entry');
                        $('#lblDesc1').text('Payments Entry');
                        $('#lblDesc2').text('Payments Detail Entry');
                        $('#cmbTransType').val("PV");
                        $('#butPrint').hide();
                        $('#butPrintDetail').hide();
                        break;
                    case "journal":
                        $('#lblRcptNum').text('Jrnl Vch#');
                        $('#TellerRow').hide();
                        $('#lblMode').text('Journal Mode');
                        $('#lblRcptDate').text('Journal Date');
                        $('#lblDesc').text('Journals Entry');
                        $('#lblDesc1').text('Journals Entry');
                        $('#lblDesc2').text('Journals Detail Entry');
                        $('#cmbTransType').val("JV");

                        $('#butPrint').hide();
                        $('#butPrintDetail').hide();
                        break;
                    default:
                        $('#lblRcptDate').text('Receipt Date');                    

                }
              //  return false;            
            }
              
            ProductLabels(); // execute this function when document is ready 

            //on focus loss
            $("#cmbTransDetailType").on('focusout', function(e) {
                e.preventDefault();
                switch ($('#txtLedgerType').val()){
                  case "T":
                     alert("ledger type value is: " + $('#txtLedgerType').val())
                     alert("detail trans type value is: " + $('#cmbTransDetailType').val())
                     if ($('#cmbTransDetailType').val() =='P' ){
                        $('#lblRef1').text("Broker");
                        $('#lblRef1').css("color", "red");
                        $('#lblRef2').text("Pol.#");
                        $('#lblRef2').css("color", "red");
                        $('#lblRef3').text("DRCR#");
                        $('#lblRef3').css("color", "red");
                     }
                     else if ($('#cmbTransDetailType').val() =='M' ){
                        $('#lblRef1').text("Broker");
                        $('#lblRef1').css("color", "red");
                        $('#lblRef2').text("Claim #");
                        $('#lblRef2').css("color", "red");
                        $('#lblRef3').text("DRCR#");
                        $('#lblRef3').css("color", "red");
                    }
                    break;
                  case "R":
                        $('#lblRef1').text("Creditor Cd");
                        $('#lblRef1').css("color", "red");
                        $('#lblRef2').text("Invoice #");
                        $('#lblRef2').css("color", "red");
                        $('#lblRef3').hide();
                        $('#txtReceiptRefNo3').hide();
                    break;
              }
            });

            $("#txtReceiptRefNo1").on('focusout', function(e) {
                e.preventDefault();
                 LoadBrokerInfo();
              
              });
            $("#txtReceiptRefNo2").on('focusout', function(e) {
                e.preventDefault();
                if ($('#txtLedgerType').val() == 'R'){
                     if ($('#cmbTransDetailType').val() =='R' ){
                        LoadInvoiceInfo();
                     }                        
                }
              
              });

            $("#txtReceiptRefNo3").on('focusout', function(e) {
                e.preventDefault();
                if ($('#txtLedgerType').val() == 'T'){
                     if ($('#cmbTransDetailType').val() =='P' ){
                        LoadDBNoteInfo();
                     }                        
                     else if ($('#cmbTransDetailType').val() =='M' ){
                        LoadClaimsDBNoteInfo();
                     }
                }
              
              });
              
            // ajax call to customer/broker information
            function LoadBrokerInfo() {
                $.ajax({
                    type: "POST",
                    url: "PRG_FIN_RECVBLE_ENTRY.aspx/GetBrokerInfo",
                    data: JSON.stringify({ _brokercode: document.getElementById('txtReceiptRefNo1').value 
                     }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess_LoadBrokerInfo,
                    failure: OnFailure_LoadDBNoteInfo,
                    error: OnError_LoadBrokerInfo
                });
                // this avoids page refresh on button click
                return false;
            }
            
            // on sucess get the xml
            function OnSuccess_LoadBrokerInfo(response) {
                //debugger;

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                var brokers = xml.find("Table");
                retrieve_BrokerInfoValues(brokers);

            }
            // retrieve the values and
            function retrieve_BrokerInfoValues(brokers) {
                //debugger;
                $.each(brokers, function() {
                    var broker = $(this);

                    document.getElementById('txtRefDesc1').value = $(this).find("sCustomerName").text()

                });
            }

            // ajax call to load invoice information
            function LoadInvoiceInfo() {
                $.ajax({
                    type: "POST",
                    url: "PRG_FIN_RECVBLE_ENTRY.aspx/GetInvoiceInfo",
                    data: JSON.stringify({ _creditorcode: document.getElementById('txtReceiptRefNo1').value, 
                    _invoiceno: document.getElementById('txtReceiptRefNo2').value,
                     }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess_LoadInvoiceInfo,
                    failure: OnFailure_LoadInvoiceInfo,
                    error: OnError_LoadInvoiceInfo
                });
                // this avoids page refresh on button click
                return false;
            }
            // on sucess get the xml
            function OnSuccess_LoadInvoiceInfo(response) {
                //debugger;

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                var invoices = xml.find("Table");
                    retrieve_LoadInvoiceInfo(invoices);

            }
            // retrieve the values and
            function retrieve_LoadInvoiceInfo(invoices) {
                //debugger;
                $.each(invoices, function() {
                    var invoice = $(this);

                    document.getElementById('txtRefAmt').value = $(this).find("sTransAmountLC").text()
                    document.getElementById('txtRefDate').value = $(this).find("sTransDate").text()

                });
            }
              
            // ajax call to load debit note information
            function LoadDBNoteInfo() {
                $.ajax({
                    type: "POST",
                    url: "PRG_FIN_RECVBLE_ENTRY.aspx/GetGrpDNoteInfo",
                    data: JSON.stringify({ _brokercode: document.getElementById('txtReceiptRefNo1').value, 
                    _policynum: document.getElementById('txtReceiptRefNo2').value,
                    _transno: document.getElementById('txtReceiptRefNo3').value,
                     }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess_LoadDBNoteInfo,
                    failure: OnFailure_LoadDBNoteInfo,
                    error: OnError_LoadDBNoteInfo
                });
                // this avoids page refresh on button click
                return false;
            }
            // on sucess get the xml
            function OnSuccess_LoadDBNoteInfo(response) {
                //debugger;

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                var policyholders = xml.find("Table");
                    retrieve_DNoteInfoValues(policyholders);

            }
            // retrieve the values and
            function retrieve_DNoteInfoValues(policyholders) {
                //debugger;
                $.each(policyholders, function() {
                    var policyholder = $(this);

                    document.getElementById('txtRefAmt').value = $(this).find("sTransAmountLC").text()
                    document.getElementById('txtRefDate').value = $(this).find("sTransDate").text()

                });
            }

            function LoadClaimsDBNoteInfo() {
                $.ajax({
                    type: "POST",
                    url: "PRG_FIN_RECVBLE_ENTRY.aspx/GetClaimsDNoteInfo",
                    data: JSON.stringify({ _brokercode: document.getElementById('txtReceiptRefNo1').value, 
                    _claimsno: document.getElementById('txtReceiptRefNo2').value,
                    _transno: document.getElementById('txtReceiptRefNo3').value,
                     }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess_LoadClaimsDBNoteInfo,
                    failure: OnFailure_LoadDBNoteInfo,
                    error: OnError_LoadDBNoteInfo
                });
                // this avoids page refresh on button click
                return false;
            }
            // on sucess get the xml
            function OnSuccess_LoadClaimsDBNoteInfo(response) {
                //debugger;

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                var claimsnotes = xml.find("Table");
                    retrieve_ClaimsDNoteInfoValues(claimsnotes);

            }
            // retrieve the values and
            function retrieve_ClaimsDNoteInfoValues(claimsnotes) {
                //debugger;
                $.each(claimsnotes, function() {
                    var claimsnote = $(this);

                    document.getElementById('txtRefAmt').value = $(this).find("sTransAmountLC").text()
                    document.getElementById('txtRefDate').value = $(this).find("sTransDate").text()

                });
            }


            //call print receipt popup 
            $('#butPrint').click(function(e) {
                e.preventDefault();
                //copy content of receipt number to the print dialog receipt number
                $('#txtRecptNo').attr('value', document.getElementById('txtReceiptNo').value)

                $('#PrintDialog').css({ display: true });
                $('#PrintDialog').modal({
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 400,
                        padding: 5,
                        width: 500
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: false,
                    opacity: 40,
                    overlayCss: { backgroundColor: "black" }

                }
              );
            });
            //call popup to ADD non existent data to trans type
            $('#TranTypeAdd').click(function(e) {
                e.preventDefault();
                var src = "\PRG_FIN_TRANS_CODE.aspx";
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 830
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 30,
                    overlayCss: { backgroundColor: "black" },
                    onClose: function(dialog) {
                        dialog.data.fadeOut('200', function() {
                            dialog.container.slideUp('200', function() {
                                dialog.overlay.fadeOut('200', function() {
                                    $.modal.close();
                                });
                            });
                        });
                    }
                });
            });

            //call popup to browse the Creditor codes
            $('#CreditorCodeSearch').click(function(e) {
                e.preventDefault();
                var src = "\AccountChartBrowse.aspx";
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 830
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 30,
                    overlayCss: { backgroundColor: "black" },
                    onClose: function(dialog) {

                        var resultValue = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue").val();
                        var resultDesc = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc").val();
                        $('#txtReceiptRefNo1').attr('value', resultValue); // creditor code
                        $('#txtRefDesc1').attr('value', resultDesc); // Creditor description
//                    
                        dialog.data.fadeOut('200', function() {
                            dialog.container.slideUp('200', function() {
                                dialog.overlay.fadeOut('200', function() {
                                    $.modal.close();
                                });
                            });
                        });
                    }
                });
            });


            //call popup to browse the main account
            $('#MainAccountSearch').click(function(e) {
                e.preventDefault();
                var src = "\AccountChartBrowse.aspx";
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 830
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 30,
                    overlayCss: { backgroundColor: "black" },
                    onClose: function(dialog) {

                        var resultValueDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue").val();
                        var resultDescDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc").val();
                        $('#txtMainAcct').attr('value', resultValueDR); // Main account code
                        $('#txtMainAcctDesc').attr('value', resultDescDR); // Main account description
//                        var resultValSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
//                        var resultDescSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();
//                        resultLedgType = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc2").val();

//                        $('#txtSubAcct').attr('value', resultValSubDR);
//                        $('#txtSubAcctDesc').attr('value', resultDescSubDR);
//                        $('#txtLedgerType').attr('value', resultLedgType);
//                    
                        dialog.data.fadeOut('200', function() {
                            dialog.container.slideUp('200', function() {
                                dialog.overlay.fadeOut('200', function() {
                                    $.modal.close();
                                });
                            });
                        });
                    }
                });
            });


            $('#SubAccountSearch').click(function(e) {
                e.preventDefault();
            var src = "\AccountChartBrowse.aspx?MainAcct=" + $('#txtMainAcct').val();
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 830
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 30,
                    overlayCss: { backgroundColor: "black" },
                    onClose: function(dialog) {

                        var resultValSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
                        var resultDescSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();
                        resultLedgType = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc2").val();

                        $('#txtSubAcct').attr('value', resultValSubDR);
                        $('#txtSubAcctDesc').attr('value', resultDescSubDR);
                       // $('#txtLedgerType').attr('value', resultLedgType);
                    
                        dialog.data.fadeOut('200', function() {
                            dialog.container.slideUp('200', function() {
                                dialog.overlay.fadeOut('200', function() {
                                    $.modal.close();
                                });
                            });
                        });
                    }
                });
            });



            //loading screen functionality - this part is additional - start
            $("#divTable").ajaxStart(OnAjaxStart);
            $("#divTable").ajaxError(OnAjaxError);
            $("#divTable").ajaxSuccess(OnAjaxSuccess);
            $("#divTable").ajaxStop(OnAjaxStop);
            $("#divTable").ajaxComplete(OnAjaxComplete);
            //loading screen functionality - this part is additional - end
        });

        // loading screen functionality functions - this part is additional - start
        function OnAjaxStart() {
            //debugger;
            //alert('Starting...');
            $("#divLoading").css("display", "block");
        }
        function OnFailure_LoadInvoiceInfo(response) {
            //debugger;
            alert('Failure!!!' + '<br/>' + response.reponseText);
        }
        function OnFailure_LoadDBNoteInfo(response) {
            //debugger;
            alert('Failure!!!' + '<br/>' + response.reponseText);
        }
        function OnError_LoadDBNoteInfo(response) {
            //debugger;
            var errorText = response.responseText;
            alert('Error!!!' + '\n\n' + ' Data Cannot be found! Check the parameters again and retry');
            $('#cmbTransDetailType').focus();       
            
        }
        function OnError_LoadInvoiceInfo(response) {
            //debugger;
            var errorText = response.responseText;
            alert('Error!!!' + '\n\n' + ' Data Cannot be found! Check the parameters again and retry');
            $('#cmbTransDetailType').focus();       
            
        }
 
        function OnError_LoadBrokerInfo(response) {
            //debugger;
            var errorText = response.responseText;
            alert('Error!!!' + '\n\n' + ' Customer/Broker Cannot be found! Check the parameters again and retry');
            $('#cmbTransDetailType').focus();       
            
        }
        
        function OnAjaxError() {
            //debugger;
            alert('Error!: Invalid Ajax Call');
        }
        function OnAjaxSuccess() {
            //debugger;
            //alert('Sucess!!!');
            $("#divLoading").css("display", "none");
        }
        function OnAjaxStop() {
            //debugger;
            //alert('Stop!!!');
            $("#divLoading").css("display", "none");
        }
        function OnAjaxComplete() {
            //debugger;
            //alert('Completed!!!');
            $("#divLoading").css("display", "none");
        }
        // loading screen functionality functions - this part is additional - end
</script>
   
    </head>
<body onload="<%=publicMsgs%>" onclick="return cancelEvent('onbeforeunload')">
    <form id="PRG_FIN_CREDITORS_ENTRY" runat="server" >
<div class="newpage">
    <table>
    <tr>
    <td>
        <asp:Literal runat="server" Visible="false" ID="litMsgs"></asp:Literal>
        <asp:Label runat="server" ID="Status" Font-Bold="true" ForeColor="Red" Visible="true" Text="Status:"> </asp:Label>
        <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    </td></tr>
    </table>

         <div class="grid">
                <div class="rounded">
                    <div class="top-outer"><div class="top-inner"><div class="top">
                        <h2><asp:Label ID="lblDesc" runat="server" Text="Invoice Entry"> </asp:Label></h2>
                    </div></div></div>
                    <div class="mid-outer"><div class="mid-inner">
                    <div class="mid">     
                    	
			    <table class="tbl_menu_new">
			        <tr><td colspan="4" class="myMenu_Title" align="center"><asp:Label ID="lblDesc1" runat="server" Text="Invoice Entry"> </asp:Label> </td><td></td><td></td><td></td></tr>
			        <tr><td><asp:Label ID="lblRcptNum" runat="server" Text="Receipt Number"> </asp:Label></td><td ><asp:TextBox ID="txtReceiptNo" runat="server" 
                            Width="150px" Enabled="False"></asp:TextBox> </td>					
			            <td>Entry Date</td>
				        <td><asp:TextBox ID="txtEntryDate" runat="server" Width="150px" Enabled="False"></asp:TextBox> </td>
                    </tr>
				    <tr>
					    <td>Company Code</td>
					    <td><asp:TextBox ID="txtCompanyCode" runat="server" Width="150px" Enabled="False"></asp:TextBox></td>
					    <td>Serial Number</td>
					    <td><asp:TextBox ID="txtSerialNo" runat="server" Width="150px" Enabled="False"></asp:TextBox></td>
				    </tr>
				    <tr>
					    <td>Batch Number</td>
					    <td><asp:TextBox ID="txtBatchNo" runat="server" Width="270px">0</asp:TextBox></td>
					    <td>Batch Date</td>
					    <td><asp:TextBox ID="txtBatchDate" runat="server" Width="150px">0</asp:TextBox>(yyyymm)</td>

				    </tr>
    				
				    <tr>
					    <td>Transaction Type</td>
					    <td><asp:Dropdownlist ID="cmbTransType" runat="server" Width="270px">
        				    <asp:ListItem Value="INV" Text="Invoice" Selected="True"></asp:ListItem>
        				    </asp:Dropdownlist></td>
                            <td>Department</td>
                            <td>
                            <asp:Dropdownlist ID="cmbDept" runat="server" Width="270px">
        				    </asp:Dropdownlist>
                            </td>

				    </tr>

				    <tr>
					    <td><asp:Label ID="lblBranch" runat="server" Text="Branch"> </asp:Label></td>
					    <td><asp:Dropdownlist ID="cmbBranchCode" runat="server" Width="150px">
        				    <asp:ListItem Value="0" Text="Branch Code"></asp:ListItem>
        				    </asp:Dropdownlist></td>
					    <td><asp:Label ID="lblInvoiceDate" runat="server" Text="Invoice Date"></asp:Label></td>
					    <td><asp:TextBox ID="txtEffectiveDate" runat="server" Width="150px"></asp:TextBox>
					    <script language="JavaScript" type="text/javascript">
					        new tcal({ 'formname': 'PRG_FIN_CREDITORS_ENTRY', 'controlname': 'txtEffectiveDate' });</script> </td>
                    
                        <asp:TextBox ID="txtProgType" runat="server" Width="15px" CssClass="popupOffset"></asp:TextBox>
				    </tr>
				    <tr><td>Trans Description</td><td><asp:TextBox ID="txtTransDesc" runat="server" Width="270px"></asp:TextBox>                            
                        </td>
                        <td >&nbsp;</td>
					    <td >&nbsp;</td>
    </tr>
				    <tr>
					    <td><asp:Label ID="Polyeffdate"  runat="server" CssClass="popupOffset"></asp:Label></td>
					    <td><asp:TextBox ID="txtPolicyEffDate" runat="server"  Width="150px" CssClass="popupOffset"> </asp:TextBox></td>
				    </tr>
                    <tr>					<td >&nbsp;</td>
					    <td>&nbsp;</td>
                        <td>&nbsp;</td><td>&nbsp;</td></tr>    				
    				
			    </table>
			    <div id="DetailPart">
			    <table class="tbl_menu_new">
			        <tr><td colspan="8" class="myMenu_Title" align="center">Other Details </td><td></td><td></td><td></td></tr>
                     <tr>
                        <td><asp:Label ID="lblMainAC" runat="server" Text="MainA/C"></asp:Label></td>
                        <td><asp:Label ID="lblSubAC" runat="server" Text="Sub A/C"></asp:Label></td>
                        <td><asp:Label ID="lblTranType" runat="server" Text="Tran Type"></asp:Label></td>
                        <td><asp:Label ID="lblRef1" runat="server" Text="Creditor Code"></asp:Label></td>
                        <td>Item</td>
                        <td>Price</td>
                        <td>Quantity</td>
                        <td><asp:Label ID="lblTranAmt" runat="server" Text="Tran Amt"></asp:Label></td>                  
                     </tr>
			         <tr>
					    <td style="white-space:nowrap"><asp:TextBox ID="txtMainAcct" runat="server" Width="70px"></asp:TextBox>
					    <img src="img/glass1.png" id="MainAccountSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="MainAcctDebitAdd" alt="add record" class="searchImage" /></td>
					    <td style="white-space:nowrap"><asp:TextBox ID="txtSubAcct" runat="server" Width="70px"></asp:TextBox><img src="img/glass1.png" id="SubAccountSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="SubAccountAdd" alt="add record" class="searchImage" />
                        </td>
					    <td style="white-space:nowrap"><asp:Dropdownlist ID="cmbTransDetailType" runat="server" Width="150px">
        				    </asp:Dropdownlist>
        			        <img src="img/plusimage.png" id="TranTypeAdd" alt="add record" class="searchImage" /></td>
				        <td style="white-space:nowrap"><asp:TextBox ID="txtReceiptRefNo1" runat="server" Width="90px"></asp:TextBox><img src="img/glass1.png" id="CreditorCodeSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="CreditorAdd" alt="add record" class="searchImage" />
				        </td>
                       
        			    <td style="white-space:nowrap">
                            <asp:TextBox ID="txtItem" runat="server" Width="80px"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="vdItem" runat="server"
                            ErrorMessage="Please Enter a Valid Item value" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtItem">*</asp:RegularExpressionValidator>
                        </td>
                        <td style="white-space:nowrap">
                            <asp:TextBox ID="txtPrice" runat="server" Width="80px"></asp:TextBox>
					    <asp:RegularExpressionValidator ID="vdPrice" runat="server"
                            ErrorMessage="Please Enter a Valid Price" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtPrice">*</asp:RegularExpressionValidator> 
                         </td>
                        <td style="white-space:nowrap"><asp:TextBox ID="txtQty" runat="server" Width="96px"></asp:TextBox>
					    <asp:RegularExpressionValidator ID="vdQty" runat="server"
                            ErrorMessage="Please Enter a Valid Quantity" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtQty">*</asp:RegularExpressionValidator> 
                         </td>
                         
                        <td style="white-space:nowrap">
                           <asp:TextBox ID="txtTransAmt" runat="server" Width="100px">0.00</asp:TextBox>
					    <asp:RegularExpressionValidator ID="vdamt" runat="server"
                            ErrorMessage="Please Enter a Valid Amount" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtTransAmt">*</asp:RegularExpressionValidator> 
                         </td>
				    </tr>				
    	
    				
                        <tr><td><asp:Label ID="lblRefDate" Text="Ref. Date" runat="server"></asp:Label>        
					        </td>
					    <td colspan=4>        
					    <asp:TextBox ID="txtRefDate" runat="server" Width="100px" 
                            Font-Bold="true"></asp:TextBox><script language="JavaScript" type="text/javascript">
                            new tcal({ 'formname': 'PRG_FIN_CREDITORS_ENTRY', 'controlname': 'txtRefDate' });</script> <asp:Label ID="lblRefAmt" Text="Ref. Amt" runat="server"></asp:Label>
                            <asp:TextBox ID="txtRefAmt" runat="server"  Width="150px" 
                                Font-Bold="true"></asp:TextBox></td><td style="white-space:nowrap"><asp:Button ID="butSaveDetail" runat="server" Text="Save" onclick="butSave_Click" />
                                <asp:Button ID="butNewDetail" runat="server" Text="New" />
                            </td>                         <td style="white-space:nowrap">
                            <asp:Button ID="butDeleteDetail" runat="server" Text="Del"  />
                            <asp:Button ID="butPrintDetail" runat="server" Text="Print" Visible="True"/>
                            </td>
                            <td style="white-space:nowrap">
                            <asp:Button ID="butClose" runat="server" Text="Close" Visible="True" /></td>
                            
				    </tr>
			    </table>
			    </div>
			    <div id="displayDetail">
    			
          <div class="grid">
                 <div class="rounded">
                    <div class="top-outer"><div class="top-inner"><div class="top">
                        <h2><asp:Label ID="lblDesc2" runat="server" Text="Invoices"></asp:Label>  </h2>
                    </div></div></div>
                    <div class="mid-outer"><div class="mid-inner">
                    <div class="mid">     
                    	
    <!-- grid end here-->
           
    <asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False"  FooterStyle-Font-Size ="11px" FooterStyle-Font-Bold="true"
             FooterStyle-ForeColor ="RosyBrown" FooterStyle-Font-Underline="true" PageSize="3"
            DataSourceID="ods1" AllowSorting="True"  AllowPaging="True" CssClass="datatable"
            CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >

    <FooterStyle Font-Bold="True" Font-Size="11px" Font-Underline="True" 
                ForeColor="RosyBrown"></FooterStyle>

            <PagerStyle CssClass="pager-row" />
               <RowStyle CssClass="row" />
                  <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
                <Columns>
                  <asp:HyperLinkField DataTextField="glId" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="Id" Visible="false"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
             
    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>

                  <asp:HyperLinkField DataTextField="CompanyCode" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="Coy"  Visible="false" 
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
             
    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>
                     
                  <asp:HyperLinkField DataTextField="BatchNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="Bat.#"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
             
    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>
             
                  <asp:HyperLinkField DataTextField="BatchDate" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="Proc Dt"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >


    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>

                  <asp:HyperLinkField DataTextField="SerialNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="SN"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >

    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>

                  <asp:HyperLinkField DataTextField="SubSerialNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo"
             DataNavigateUrlFormatString="~/PRG_FIN_CREDITORS_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}" HeaderText="SSN"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >

    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>

                    <asp:BoundField DataField="DocNo" HeaderText="Doc#"/>
                    <asp:BoundField DataField="MainAccountDR" HeaderText="Main A/C"/>
                    <asp:BoundField DataField="SubAccountDR" HeaderText="Sub A/C"/>
                    <asp:BoundField DataField="DRCR" HeaderText="DR/CR"/>
                    <asp:BoundField DataField="TransId" HeaderText="Trans #" />
                    <asp:BoundField DataField="TransDate" HeaderText="Trans Dt" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="TransMode" HeaderText="Mode" />
                    <asp:BoundField DataField="ChequeNo" HeaderText="Chq #" />
                    <asp:BoundField DataField="ChequeDate" HeaderText="Chq Dt" DataFormatString="{0:d}"/>
                    <asp:BoundField DataField="TransDescription" HeaderText="Trans. Desc" />
                    <asp:BoundField DataField="RefNo1" HeaderText="Ref. 1" />
                    <asp:BoundField DataField="RefNo2" HeaderText="Ref. 2" />
                    <asp:BoundField DataField="RefNo3" HeaderText="Ref. 3" />
                    <asp:BoundField DataField="RefAmount" DataFormatString="{0:N2}" HeaderText="Ref. Amt" />                
                    <asp:TemplateField  HeaderText="Trans. Amt">
                      <ItemTemplate>
                       <asp:Label ID="lblTransAmt" runat="server" DataFormatString="{0:N2}" Text='<%#Eval("GLAmountLC") %>' />
                      </ItemTemplate>

                      <FooterTemplate>

                       <asp:Label ID="lbltxtTotal" runat="server" Text="0.00" />

                      </FooterTemplate>

                      </asp:TemplateField>                
                                    
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
               TypeName="CustodianLife.Data.GLTransRepository" 
                        OldValuesParameterFormatString="original_{0}">
                 <SelectParameters>
                     <asp:Parameter DefaultValue="BatchNo" Name="_key" Type="String" />
                     <asp:ControlParameter ControlID="txtBatchNo" DefaultValue="" Name="_value" 
                         PropertyName="Text" Type="String" />
                     <asp:ControlParameter ControlID="txtProgType" DefaultValue="" Name="_prg" 
                         PropertyName="Text" Type="String" />
                 </SelectParameters>
        </asp:ObjectDataSource>  
     				
			    </div>
    			
			     </div></div></div>
                <div class="bottom-outer"><div class="bottom-inner">
                <div class="bottom"></div></div></div>                
            </div> 
            <div id="displays">
        <table>
           <tr>
					    <td></td>
					    <td>
					    <asp:TextBox ID="txtMainAcctDesc" runat="server" Width="200px" Enabled="false"></asp:TextBox>
					    <asp:TextBox ID="txtSubAcctDesc" runat="server" Width="170px" Enabled="false"></asp:TextBox>
					    <asp:TextBox ID="txtRefDesc1" runat="server"  Enabled="false" Width="170px"></asp:TextBox>
					    <asp:TextBox ID="txtRefDesc2" runat="server" Width="170px" Enabled="false"></asp:TextBox>
					    <asp:TextBox ID="txtRefDesc3" runat="server" Width="170px" Enabled="false"></asp:TextBox>
					    </td>
					    <td> </td>
					    <td>
                        </td>
                                </tr>
        </table>     
        </div>
    </div>
        <div id="divTable">
        </div>

    <div id="PrintDialog" class="nodisplay">
        <table>
            <tr><td>Invoice No</td>
			    <td ><asp:TextBox ID="txtInvoiceNo" runat="server" Width="100px"></asp:TextBox></td></tr>
            <tr><td></td><td><asp:Button ID="butPrintReceipt" runat="server" Text="Print" Visible="True" /></td></tr>
        </table>

    </div>
</div>
		</form>
</body>
</html>
