<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_RECVBLE_ENTRY.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_RECVBLE_ENTRY" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    
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

            function GeneralRefresh(){
               
               if ($('#txtLedgerType').val() == 'T' || $('#txtLedgerType').val() == 'R'){
                     if ($('#cmbTransDetailType').val() =='P' || $('#cmbTransDetailType').val() =='R' ){
                        LoadBrokerInfo();
                     }                        
                }
                
                if ($('#txtLedgerType').val() == 'R'){
                     if ($('#cmbTransDetailType').val() =='R' ){
                        LoadInvoiceInfo();
                     }                        
                }

                if ($('#txtLedgerType').val() == 'T'){
                   if ($('#cmbTransDetailType').val() =='P' ){
                        LoadDBNoteInfo();
                     }                        
                     else if ($('#cmbTransDetailType').val() =='M' ){
                        LoadClaimsDBNoteInfo();
                     }
                }
            }            
            function LedgerTypeRefresh(){
            
             switch ($('#txtLedgerType').val()){
                  case "T":
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

          }
                                      
            function ProductLabels() {
                switch ($('#txtProgType').val()) {
                    case "payment":
                    case "PV":
                        $('#lblRcptNum').text('Payment No');
                        $('#TellerRow').hide();
                        $('#lblMode').text('Payment Mode');
                        $('#lblRcptDate').text('Payment Date');
                        $('#lblDesc').text('Payments Entry');
                        $('#lblDesc1').text('Payments Entry');
                        $('#lblDesc2').text('Payments Detail Entry');
                        $('#cmbTransType').val("PV");
                        $('#cmbTransType').attr("disabled", "disabled");
                        $('#butPrint').hide();
                        $('#butPrintDetail').hide();
                        $('#lblPrintLabel').text('Payment Voucher #');
                        $('#totamt').hide();
                        $('#totamtlbl').hide();
                        break;
                    case "journal":
                    case "JV":
                        $('#lblRcptNum').text('Jrnl Vch#');
                        $('#TellerRow').hide();
                        $('#NonJV').hide();
                        $('#lblMode').text('Journal Mode');
                        $('#lblRcptDate').text('Journal Date');
                        $('#lblDesc').text('Journals Entry');
                        $('#lblDesc1').text('Journals Entry');
                        $('#lblDesc2').text('Journals Detail Entry');
                        $('#cmbTransType').val("JV");
                        $('#cmbTransType').attr("disabled", "disabled");
                        $('#butPrint').show();
                        $('#butPrintDetail').hide();
                        $('#lblPrintLabel').text('Journal Voucher #');
                        $('#totamt').hide();
                        $('#totamtlbl').hide();
                        break;
                    default:
                        $('#lblRcptDate').text('Receipt Date');                    
                        $('#cmbTransType').val("R");
                        $('#cmbTransType').attr("disabled", "disabled");
                        $('#totamt').hide();
                        $('#totamtlbl').hide();
                        
                }
              //  return false;            
            }
              
            // execute these functions when document is ready (i.e after screen refresh)
            GeneralRefresh();
            ProductLabels(); 
            LedgerTypeRefresh();
            //on focus loss
            $("#cmbTransDetailType").on('focusout', function(e) {
                e.preventDefault();
                LedgerTypeRefresh()
            });

            $("#txtReceiptRefNo1").on('focusout', function(e) {
                e.preventDefault();
                if ($('#txtLedgerType').val() == 'T' || $('#txtLedgerType').val() == 'R'){
                     if ($('#cmbTransDetailType').val() =='P' || $('#cmbTransDetailType').val() =='R' ){
                        LoadBrokerInfo();
                     }                        
                }
              
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
                
            //retrieve data on focus loss
            $("#txtMainAcct").on('focusout', function(e) {
                e.preventDefault();
                if ($("#txtMainAcct").val() != "")
                    LoadChartInfo("txtMainAcct", "Main", "DR");
                //return false;
            });
            //retrieve data on focus loss
            $("#txtSubAcct").on('focusout', function(e) {
                e.preventDefault();
                if ($("#txtSubAcct").val() != "")
                    LoadChartInfo("txtSubAcct", "Sub", "DR");
            });
      
              // ajax call to load account chart information
            function LoadChartInfo(accountcode, ctype, drcr) {
                $.ajax({
                    type: "POST",
                    url: "PRG_FIN_RECPT_ISSUE.aspx/GetAccountChartDetails",
                    data: JSON.stringify({ _accountcode: document.getElementById(accountcode).value, _type: ctype}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success:   function (data) {
                    var xmlDoc = $.parseXML(data.d);
                    var xml = $(xmlDoc);
                    var accountcharts = xml.find("Table");
                    retrieve_AccountChartInfoValues(accountcharts, ctype, drcr)},
                    failure: OnFailure_LoadChartInfo,
                    error: OnError_LoadChartInfo
                });
                // this avoids page refresh on button click
                return false;
            }
            // retrieve the values and
            function retrieve_AccountChartInfoValues(accountcharts, ctype, drcr) {
                //debugger;
                $.each(accountcharts, function() {
                var accountchart = $(this);

                if (ctype == "Main" && drcr == "DR") {

                    document.getElementById('txtMainAcctDesc').value = $(this).find("sMainDesc").text()
                    document.getElementById('txtLedgerType').value = $(this).find("sLedgType").text()
                    }
                else if (ctype == "Sub" && drcr == "DR") {
                    document.getElementById('txtMainAcct').value = $(this).find("sMainCode").text()
                    document.getElementById('txtMainAcctDesc').value = $(this).find("sMainDesc").text()
                    document.getElementById('txtSubAcctDesc').value = $(this).find("sSubDesc").text()
                    document.getElementById('txtLedgerType').value = $(this).find("sLedgType").text()
                }

                });
            }


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
                    _invoiceno: document.getElementById('txtReceiptRefNo2').value}),
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
                    _transno: document.getElementById('txtReceiptRefNo3').value}),
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
                    _transno: document.getElementById('txtReceiptRefNo3').value}),
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

            //call popup to add to the main account
            $('#MainAcctAdd').click(function(e) {
                e.preventDefault();
                var src = "\ChartOfAccountsEntryBrowse.aspx";
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="1100" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 1100
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 50,
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


            //call popup to browse the main account SubAccountSearch
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
                        resultLedgType = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc2").val();

                        $('#txtLedgerType').attr('value', resultLedgType);
                    
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

            //call popup to add to the sub account
            $('#SubAccountAdd').click(function(e) {
                e.preventDefault();
                var src = "\ChartOfAccountsEntryBrowse.aspx";
                $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="1100" style="border:0">', {
                    closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                    containerCss: {
                        backgroundColor: "#fff",
                        borderColor: "#fff",
                        height: 500,
                        padding: 0,
                        width: 1100
                    },
                    appendTo: 'form',
                    persist: true,
                    overlayClose: true,
                    opacity: 50,
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


            //call popup to browse the main account 
            $('#SubAccountSearch').click(function(e) {
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

                        var resultValSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
                        var resultDescSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();

                        $('#txtSubAcct').attr('value', resultValSubDR);
                        $('#txtSubAcctDesc').attr('value', resultDescSubDR);
                    
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
            //debugger;`
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
        function OnFailure_LoadChartInfo(response) {
            //debugger;`
            alert('Failure!!!' + '<br/>' + response.reponseText);
        }
        function OnError_LoadChartInfo(response) {
         //debugger;
         //var errorText = response.responseText;
         //alert('Error!!!' + '\n\n' + errorText);
         alert('Error!: Account Chart could not be Retrieved. Parameters sent is empty or invalid. Please Re-Confirm' + '<br/>');
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
    <form id="PRG_FIN_RECVBLE_ENTRY" runat="server" submitdisabledcontrols="true">
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
                        <h2><asp:Label ID="lblDesc" runat="server" Text="Other Reciepts Entry"> </asp:Label></h2>
                    </div></div></div>
                    <div class="mid-outer"><div class="mid-inner">
                    <div class="mid">     
                    	
			    <table class="tbl_menu_new">
			        <tr><td colspan="4" class="myMenu_Title" align="center"><asp:Label ID="lblDesc1" runat="server" Text="Other Reciepts Entry"> </asp:Label> </td><td></td><td></td><td></td></tr>
			        <tr><td><asp:Label ID="lblRcptNum" runat="server" Text="Receipt Number"> </asp:Label></td><td ><asp:TextBox ID="txtReceiptNo" runat="server" tabindex=1 
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
					    <td><asp:TextBox ID="txtBatchNo" runat="server" Width="270px" tabindex=2>0</asp:TextBox></td>
					    <td>Batch Date</td>
					    <td><asp:TextBox ID="txtBatchDate" runat="server" Width="150px" tabindex=3>0</asp:TextBox>(yyyymm)</td>

				    </tr>
    				
				    <tr>
					    <td>Transaction Type</td>
					    <td><asp:Dropdownlist ID="cmbTransType" runat="server" Width="270px" tabindex=4 >
        				    <asp:ListItem Value="R" Text="Receipt" ></asp:ListItem>
        				    <asp:ListItem Value="PV" Text="Payment" ></asp:ListItem>
        				    <asp:ListItem Value="JV" Text="Journal" ></asp:ListItem>
        				    </asp:Dropdownlist></td>
                            <td>Department</td>
                            <td>
                            <asp:Dropdownlist ID="cmbDept" runat="server" Width="270px" tabindex=5>
        				    </asp:Dropdownlist>
                            </td>

				    </tr>

				    <tr>
					    <td><asp:Label ID="lblMode" runat="server" Text="Receipt Mode"> </asp:Label></td>
					    <td><asp:Dropdownlist ID="cmbMode" runat="server" Width="270px" tabindex=6>
        				    <asp:ListItem Value="0" Text="Mode"></asp:ListItem>
        				    <asp:ListItem Value="C" Text="Cash"></asp:ListItem>
        				    <asp:ListItem Value="Q" Text="Cheque"></asp:ListItem>
        				    <asp:ListItem Value="D" Text="Direct Payment To Bank"></asp:ListItem>
        				    <asp:ListItem Value="T" Text="Teller"></asp:ListItem>
        				    </asp:Dropdownlist></td>
					    <td><asp:Label ID="lblRcptDate" runat="server" Text="Receipt Date"></asp:Label></td>
					    <td><asp:TextBox ID="txtEffectiveDate" runat="server" Width="150px" tabindex=8></asp:TextBox>
					    <script language="JavaScript" type="text/javascript" tabindex=7>
					        new tcal({ 'formname': 'PRG_FIN_RECVBLE_ENTRY', 'controlname': 'txtEffectiveDate' });</script> </td>
                    
                        <asp:TextBox ID="txtProgType" runat="server" Width="15px" CssClass="popupOffset"></asp:TextBox>
				    </tr>
				    <tr id="TellerRow">
					    <td>Teller Number</td>
					    <td ><asp:TextBox ID="txtTellerNo" runat="server" Width="270px"></asp:TextBox></td>
                        <td>Teller Date</td>
                        <td><asp:TextBox ID="txtTellerDate" runat="server" Width="150px">01/01/2014</asp:TextBox>
                        <script language="JavaScript" type="text/javascript">
                            new tcal({ 'formname': 'PRG_FIN_RECVBLE_ENTRY', 'controlname': 'txtTellerDate' });</script></td>
				    </tr>
				    <tr>
					    <td>Cheque Num</td>
					    <td><asp:TextBox ID="txtChequeNo" runat="server" Width="270px" tabindex=9></asp:TextBox></td>
                        <td>Cheque Date</td><td><asp:TextBox ID="txtChequeDate" runat="server" Width="150px" tabindex=11></asp:TextBox>					
                            <script language="JavaScript" type="text/javascript" tabindex=10>
                                new tcal({ 'formname': 'PRG_FIN_RECVBLE_ENTRY', 'controlname': 'txtChequeDate' });</script>
                        </td>

				    </tr>
				    <tr><td>Curr. Type</td><td><asp:Dropdownlist ID="cmbCurrencyType" runat="server" Width="100px" tabindex=12>
        				    <asp:ListItem Value="0" Text="Currency Type"></asp:ListItem>
        				    </asp:Dropdownlist>
                        <asp:CustomValidator ID="csValidateCurrencyType" runat="server" 
                            ErrorMessage="Please Select the Currency Type">*</asp:CustomValidator>
                            Branch<asp:Dropdownlist ID="cmbBranchCode" runat="server" Width="150px" tabindex=13>
        				    <asp:ListItem Value="0" Text="Branch Code"></asp:ListItem>
        				    </asp:Dropdownlist>
                        </td>
                        <td id="totamtlbl">Total Amount</td>
					    <td id="totamt" ><asp:TextBox ID="txtTotalAmt" tabindex=14 runat="server" Width="150px">0.00 </asp:TextBox></td>
    </tr>
				    <tr>
					    <td><asp:Label ID="Polyeffdate"  runat="server" CssClass="popupOffset"></asp:Label></td>
					    <td><asp:TextBox ID="txtPolicyEffDate" runat="server"  Width="150px" CssClass="popupOffset"> </asp:TextBox></td>
				    </tr>
                    <tr id="NonJV"><td><asp:Label ID="lblPayeeName"  runat="server" Text="Payee Name" ></asp:Label></td>
					    <td><asp:TextBox ID="txtPayeeName" runat="server" Width="270px" tabindex=15></asp:TextBox></td>
                        <td><asp:Label ID="lblRemarks"  runat="server"  Text="Remarks"></asp:Label></td>
					    <td><asp:TextBox ID="txtRemarks" runat="server" Width="270px" tabindex=16></asp:TextBox></td>
                    </tr>
				    <tr>
                        <td><asp:Label ID="lblTransDesc"  runat="server"  Text="Trans Description"></asp:Label></td>
                        <td><asp:TextBox ID="txtTransDesc" runat="server" Width="270px" tabindex=17></asp:TextBox></td>				    
				    <td></td> <td><asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" />
                            <asp:Button ID="butNew" runat="server" Text="New Hdr"  />
                            <asp:Button ID="butDelete" runat="server" Text="Delete"  />
                            <asp:Button ID="butPrint" runat="server" Text="Print" Visible="True" />
                            <asp:Button ID="butClose" runat="server" Text="Close" Visible="True" /></td>
					    <td>&nbsp;</td>

				    </tr>
    				
    				
			    </table>
			    <div id="DetailPart">
			    <table class="tbl_menu_new">
			        <tr><td colspan="9" class="myMenu_Title" align="center">Transaction Detail Entry</td><td></td><td></td><td></td></tr>
                     <tr>
                        <td><asp:Label ID="lblMainAC" runat="server" Text="MainA/C"></asp:Label></td>
                        <td><asp:Label ID="lblSubAC" runat="server" Text="Sub A/C"></asp:Label></td>
                        <td><asp:Label ID="lblLedgerType" runat="server" Text="Typ"></asp:Label></td>
                        <td><asp:Label ID="lblTranType" runat="server" Text="Tran Type"></asp:Label></td>
                        <td><asp:Label ID="lblDRCR" runat="server" Text="DR/CR"></asp:Label></td>
                        <td><asp:Label ID="lblRef1" runat="server" Text="Ref. No 1"></asp:Label></td>
                        <td><asp:Label ID="lblRef2" runat="server" Text="Ref. No 2"></asp:Label></td>
                        <td><asp:Label ID="lblRef3" runat="server" Text="Ref. No 3"></asp:Label></td>
                        <td><asp:Label ID="lblTranAmt" runat="server" Text="Tran Amt"></asp:Label></td>                  
                     </tr>
			         <tr>
					    <td style="white-space:nowrap"><asp:TextBox ID="txtMainAcct" runat="server" Width="70px"></asp:TextBox>
					    <img src="img/glass1.png" id="MainAccountSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="MainAcctAdd" alt="add record" class="searchImage" /></td>
					    <td style="white-space:nowrap"><asp:TextBox ID="txtSubAcct" runat="server" Width="70px"></asp:TextBox><img src="img/glass1.png" id="SubAccountSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="SubAccountAdd" alt="add record" class="searchImage" /></td>
					    <td><asp:TextBox ID="txtLedgerType" runat="server" Width="25px"></asp:TextBox></td>
					    <td style="white-space:nowrap"><asp:Dropdownlist ID="cmbTransDetailType" runat="server" Width="150px">
        				    </asp:Dropdownlist><img src="img/plusimage.png" id="TranTypeAdd" alt="add record" class="searchImage" />
        			    </td>
				        <td><asp:Dropdownlist ID="cmbDRCR" runat="server" Width="70px">
        				    <asp:ListItem Value="0" Text="DR/CR"></asp:ListItem>
        				    <asp:ListItem Value="D" Text="Debit" Selected="True"></asp:ListItem>
        				    <asp:ListItem Value="C" Text="Credit"></asp:ListItem>
        				    </asp:Dropdownlist> 
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please Select the DR/CR Type"
                            ControlToValidate="cmbDRCR">*</asp:CustomValidator>
				        </td>
                       
        			    <td><asp:TextBox ID="txtReceiptRefNo1" runat="server" Width="90px"></asp:TextBox>
                        </td>
                        <td><asp:TextBox ID="txtReceiptRefNo2" runat="server" Width="90px"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtReceiptRefNo3" runat="server" Width="90px"></asp:TextBox></td>
                         
                        <td>
                           <asp:TextBox ID="txtTransAmt" runat="server" Width="100px">0.00</asp:TextBox>
					    <asp:RegularExpressionValidator ID="vdamt" runat="server"
                            ErrorMessage="Please Enter a Valid Amount" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtTransAmt">*</asp:RegularExpressionValidator> 
					    </td>
				    </tr>				
    	
    				
                        <tr><td>S/No<asp:TextBox ID="txtSubSerialNo" runat="server" BorderStyle="None" Width="30px" 
                                Height="22px"></asp:TextBox></td>
					    <td colspan=5><asp:Label ID="lblRefDate" Text="Ref. Date" runat="server"></asp:Label>        
					    <asp:TextBox ID="txtRefDate" runat="server" Width="100px" BorderStyle="None"
                            Font-Bold="true"></asp:TextBox><asp:Label ID="lblRefAmt" Text="Ref. Amt" runat="server"></asp:Label>
                            <asp:TextBox ID="txtRefAmt" runat="server" BorderStyle="None" Width="150px" Text="0.00" 
                                Font-Bold="true"></asp:TextBox></td><td></td>                         <td><asp:Button ID="butSaveDetail" runat="server" Text="Save" onclick="butSave_Click" />
                                <asp:Button ID="butNewDetail" runat="server" Text="New" />
                            </td>
                            <td>
                            <asp:Button ID="butDeleteDetail" runat="server" Text="Del"  />
                            <asp:Button ID="butPrintDetail" runat="server" Text="Print" Visible="True"/></td>
                            
				    </tr>
			    </table>
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
			    <div id="displayDetail">
    			
          <div class="grid">
                 <div class="rounded">
                    <div class="top-outer"><div class="top-inner"><div class="top">
                        <h2><asp:Label ID="lblDesc2" runat="server" Text="Reciepts Details Entry"></asp:Label>  </h2>
                    </div></div></div>
                    <div class="mid-outer"><div class="mid-inner">
                    <div class="mid">     
                    	
    <!-- grid end here-->
           
    <asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False"  FooterStyle-Font-Size ="11px" FooterStyle-Font-Bold="true"
             FooterStyle-ForeColor ="RosyBrown" FooterStyle-Font-Underline="true" PageSize="3"
            DataSourceID="ods1" AllowSorting="True" CssClass="datatable"
            CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >

    <FooterStyle Font-Bold="True" Font-Size="11px" Font-Underline="True" 
                ForeColor="RosyBrown"></FooterStyle>

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
             DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Coy"  Visible="false" 
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
             
    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>
                     
                  <asp:HyperLinkField DataTextField="BatchNo" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
             DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Bat.#"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >
             
    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>
             
                  <asp:HyperLinkField DataTextField="BatchDate" DataNavigateUrlFields="glId,CompanyCode,BatchNo,BatchDate,SerialNo,SubSerialNo,TransType"
             DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="Proc Dt"  
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
             DataNavigateUrlFormatString="~/PRG_FIN_RECVBLE_ENTRY.aspx?idd={0},{1},{2},{3},{4},{5}&prgKey={6}" HeaderText="SSN"  
             HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  >

    <HeaderStyle CssClass="first"></HeaderStyle>

    <ItemStyle CssClass="first"></ItemStyle>
                    </asp:HyperLinkField>

                    <asp:BoundField DataField="DocNo" HeaderText="Doc#"/>
                    <asp:BoundField DataField="MainAccount" HeaderText="Main A/C"/>
                    <asp:BoundField DataField="SubAccount" HeaderText="Sub A/C"/>
                    <asp:BoundField DataField="DRCR" HeaderText="DR/CR"/>
                    <asp:BoundField DataField="TransId" HeaderText="Trans #" />
                    <asp:BoundField DataField="TransDate" HeaderText="Trans Dt" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="TransMode" HeaderText="Mode" />
                    <asp:BoundField DataField="ChequeNo" HeaderText="Chq #" />
                    <asp:BoundField DataField="ChequeDate" HeaderText="Chq Dt" DataFormatString="{0:d}"/>
                    <asp:BoundField DataField="TransDescription" HeaderText="Trans. Desc" />
                    <asp:BoundField DataField="RefNo1" HeaderText="Ref. 1" />
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
                     <asp:Parameter DefaultValue="Code2" Name="_key" Type="String" />
                     <asp:ControlParameter ControlID="txtReceiptNo" DefaultValue="Z" Name="_value" 
                         PropertyName="Text" Type="String" />
                     <asp:ControlParameter ControlID="txtProgType" DefaultValue="" Name="_prg" 
                         PropertyName="Text" Type="String" />
                     <asp:Parameter DefaultValue="0" Name="_searchDirection" Type="Int32" />
                 </SelectParameters>
        </asp:ObjectDataSource>  
     				
			    </div>
    			
			     </div></div></div>
                <div class="bottom-outer"><div class="bottom-inner">
                <div class="bottom"></div></div></div>                
            </div> 
            <div id="displays">
        </div>
    </div>
        <div id="divTable">
        </div>

    <div id="PrintDialog" class="nodisplay">
        <table>
            <tr><td><asp:Label ID="lblPrintLabel" runat="server" Text="Receipt Number"> </asp:Label> </td>
			    <td ><asp:TextBox ID="txtRecptNo" runat="server" Width="100px"></asp:TextBox></td></tr>
            <tr><td></td><td><asp:Button ID="butPrintReceipt" runat="server" Text="Print" Visible="True" /></td></tr>
        </table>

    </div>
</div>
		</form>
</body>
</html>
