Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Imports System.Xml.Serialization
Imports System.Xml
Imports System.IO
Imports System.Globalization

Partial Public Class PRG_FIN_RECVBLE_ENTRY
    Inherits System.Web.UI.Page

    Dim gtRepo As GLTransRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim transTypeEnq As TransactionTypesRepository
    '    Dim hHelper As HashHelper
    Dim polinfo As PolicyInfo
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim prgKey As String
    Dim Save_Amount As Decimal = 0
    Dim Cum_Detail_Amount As Decimal = 0
    Dim Gtrans As CustodianLife.Model.GLTrans
    Dim swEntry As String = "H"
    Dim detailEdit As String = "N"
    Dim TotTransAmt As Decimal = 0
    Dim TransAmt As Decimal = 0
    Dim TransType As String
    Dim newDocRefNo As String
    Protected publicMsgs As String = String.Empty
    Protected ci As CultureInfo



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtSubSerialNo.Attributes.Add("disabled", "disabled")
        txtRefAmt.Attributes.Add("disabled", "disabled")
        txtRefDate.Attributes.Add("disabled", "disabled")
        txtLedgerType.Attributes.Add("disabled", "disabled")

        If Not Page.IsPostBack Then
            'set globalization and culture -- date issues

            ci = New CultureInfo("en-GB")
            Session("ci") = ci

            gtRepo = New GLTransRepository
            indLifeEnq = New IndLifeCodesRepository
            transTypeEnq = New TransactionTypesRepository

            Session("gtRepo") = gtRepo
            updateFlag = False
            Session("updateFlag") = updateFlag
            swEntry = "H"
            Session("swEntry") = swEntry

            strKey = Request.QueryString("idd")
            prgKey = Request.QueryString("prgKey")
            Session("prgKey") = prgKey
            txtProgType.Text = prgKey
            Session("gtId") = strKey
            Session("Save_Amount") = Save_Amount
            Session("Cum_Detail_Amount") = Cum_Detail_Amount
            'Company code value to be filled from login
            txtCompanyCode.Text = "001"
            txtEntryDate.Text = Now.Date.ToString()
            txtEntryDate.ReadOnly = True
            lblError.Visible = False
            'If prgKey = "journal" Or prgKey = "payment" Then
            '    txtReceiptNo.Enabled = True
            'End If


            SetComboBinding(cmbBranchCode, indLifeEnq.GetById("L02", "003"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbCurrencyType, indLifeEnq.GetById("L02", "017"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbDept, indLifeEnq.GetById("L02", "005"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbTransDetailType, transTypeEnq.TransactionTypesDetails, "Description", "TransactionCode")

            cmbTransType.Attributes.Add("readonly", "readonly")

            If strKey IsNot Nothing Then
                fillValues()
            Else
                gtRepo = CType(Session("gtRepo"), GLTransRepository)
            End If

        Else 'post back

            Me.Validate()
            If (Not Me.IsValid) Then
                Dim msg As String
                ' Loop through all validation controls to see which 
                ' generated the error(s).
                Dim oValidator As IValidator
                For Each oValidator In Validators
                    If oValidator.IsValid = False Then
                        msg = msg & "\n" & oValidator.ErrorMessage
                    End If
                Next

                lblError.Text = msg
                lblError.Visible = True
                publicMsgs = "javascript:alert('" + msg + "')"
            End If



            ci = CType(Session("ci"), CultureInfo)


        End If


    End Sub


    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click, butSaveDetail.Click
        Dim msg As String = String.Empty
        Dim docMonth As String = String.Empty
        Dim docYear As String = String.Empty

        Try
            If Me.IsValid Then

                'this routine will persist only one object. 
                '1. The GlTrans object

                updateFlag = CType(Session("updateFlag"), Boolean)


                If Not updateFlag Then 'if new record

                    'create a new instance of the GLTrans object
                    Gtrans = New CustodianLife.Model.GLTrans()
                    gtRepo = New GLTransRepository()
                    lblError.Visible = False

                    With Gtrans
                        .BatchDate = CType(txtBatchDate.Text, Integer)
                        .BatchNo = CType(txtBatchNo.Text, Integer)
                        .BranchCode = cmbBranchCode.SelectedValue.ToString()

                        If Trim(txtChequeDate.Text).Length > 0 Then
                            .ChequeDate = ValidDate(txtChequeDate.Text)
                        Else
                            .ChequeDate = #1/1/2014#
                        End If

                        .ChequeNo = txtChequeNo.Text
                        .ClientName = txtPayeeName.Text
                        .CompanyCode = txtCompanyCode.Text
                        .CurrencyType = cmbCurrencyType.SelectedValue.ToString()
                        .DeptCode = cmbDept.SelectedValue.ToString()
                        .DocNo = txtReceiptNo.Text
                        .EntryDate = Now.Date

                        .MainAccount = txtMainAcct.Text
                        .OperatorId = "001"
                        .PostStatus = "U" 'Unposted
                        .ApprovalStatus = "N"
                        .RecordStatus = "A"
                        .Remarks = txtRemarks.Text

                        .SubAccount = txtSubAcct.Text
                        If Trim(txtTellerDate.Text).Length > 0 Then
                            .TellerDate = ValidDate(txtTellerDate.Text)
                        Else
                            .TellerDate = #1/1/2014#
                        End If

                        .TellerNo = txtTellerNo.Text
                        If Trim(txtTellerDate.Text).Length > 0 Then
                            .TransDate = ValidDate(txtEffectiveDate.Text)
                        Else
                            .TransDate = #1/1/2014#
                        End If

                        .TransDescription = txtTransDesc.Text
                        .TransId = "H" 'header
                        .TransType = cmbTransType.SelectedValue.ToString()
                        '.TotalAmt = CType(txtTotalAmt.Text, Decimal)  'detail amounts must total to this
                        Save_Amount = CType(txtTotalAmt.Text, Decimal)
                        Session("Save_Amount") = Save_Amount

                        Cum_Detail_Amount = 0
                        Session("Cum_Detail_Amount") = Cum_Detail_Amount

                        docMonth = Right(txtBatchDate.Text, 2)
                        docYear = Left(txtBatchDate.Text, 4)
                        'get new serial number
                        'L02(other receipts) , 001 -- for main serial number 
                        'L02(other receipts), 002 -- for Sub serial number 
                        If .TransId = "H" Then
                            Dim newSerialNum As String = gtRepo.GetNextSerialNumber("L02", "001", docMonth, docYear, " ", "12", "11")

                            prgKey = Session("prgKey")
                            If prgKey = "journal" Or prgKey = "JV" Then
                                .TransType = "JV"
                                'get new journal number
                                newDocRefNo = gtRepo.GetNextSerialNumber("JNL", _
                                                                         "001", _
                                                                         "001", _
                                                                       docYear, _
                                                                      "JV/", _
                                                                          "13", _
                                                                           "12")
                            ElseIf prgKey = "payment" Or prgKey = "PV" Then
                                .TransType = "PV"
                                'get new Payment voucher number
                                newDocRefNo = gtRepo.GetNextSerialNumber("PMT", _
                                                                         "001", _
                                                                         "001", _
                                                                       docYear, _
                                                                      "PV/", _
                                                                          "13", _
                                                                           "12")
                            Else
                                .TransType = "R"
                                'get new receipt number
                                newDocRefNo = gtRepo.GetNextSerialNumber("RCN", _
                                                                         "001", _
                                                                         "001", _
                                                                       docYear, _
                                                                      "IL-BR-", _
                                                                          "13", _
                                                                           "12")
                            End If
                            txtReceiptNo.Text = newDocRefNo
                            txtSerialNo.Text = newSerialNum
                            .SerialNo = CType(txtSerialNo.Text, Long)
                            .DocNo = Trim(txtReceiptNo.Text)

                        End If
                        .TransMode = cmbMode.SelectedValue.ToString

                        'initialize details part
                        .DetailTransType = String.Empty 'D
                        .DRCR = String.Empty 'D
                        .GLAmountLC = 0.0 'D
                        .GLAmountFC = 0.0 'D
                        .RefAmount = 0.0 'D
                        .RefDate = #1/1/2014# 'D
                        .RefNo1 = String.Empty 'D
                        .RefNo2 = String.Empty 'D
                        .RefNo3 = String.Empty 'D
                        .RefAmount = 0.0  'D
                        .SubSerialNo = 0 'D

                        'save
                        gtRepo.Save(Gtrans)
                        grdData.DataBind()
                        Session("Gtrans") = Gtrans
                        updateFlag = True
                        Session("updateFlag") = updateFlag
                        detailEdit = "N"
                        Session("detailEdit") = detailEdit
                        ' initializeDetailFields()
                    End With
                Else
                    swEntry = CType(Session("swEntry"), String)
                    If swEntry = "D" Then
                        Gtrans = New CustodianLife.Model.GLTrans() 'a new object but filled with old values with the only changes from the detail part
                        detailEdit = "N"
                        Session("detailEdit") = detailEdit ' detail records in new rec mode

                    Else
                        detailEdit = Session("detailEdit") ' detail records in edit mode
                        Gtrans = CType(Session("Gtrans"), CustodianLife.Model.GLTrans)
                    End If
                    gtRepo = CType(Session("gtRepo"), GLTransRepository)


                    With Gtrans
                        .BatchDate = CType(txtBatchDate.Text, Integer)
                        .BatchNo = CType(txtBatchNo.Text, Integer)
                        .BranchCode = cmbBranchCode.SelectedValue.ToString()

                        If Trim(txtChequeDate.Text).Length > 0 Then
                            .ChequeDate = ValidDate(txtChequeDate.Text)
                        Else
                            .ChequeDate = #1/1/2014#
                        End If

                        .ChequeNo = txtChequeNo.Text
                        .ClientName = txtPayeeName.Text
                        .CompanyCode = txtCompanyCode.Text
                        .CurrencyType = cmbCurrencyType.SelectedValue.ToString()
                        .DeptCode = cmbDept.SelectedValue.ToString()
                        .DocNo = txtReceiptNo.Text
                        .EntryDate = Now.Date
                        '.TotalAmt = Math.Round(CType(txtTotalAmt.Text, Decimal), 2)
                        .DetailTransType = cmbTransDetailType.SelectedValue.ToString 'D
                        .DRCR = cmbDRCR.SelectedValue.ToString 'D
                        .GLAmountLC = Math.Round(CType(txtTransAmt.Text, Decimal), 2) 'D

                        .RefAmount = CType(txtRefAmt.Text, Decimal) 'D

                        If Trim(txtRefDate.Text).Length > 0 Then
                            .RefDate = ValidDate(txtRefDate.Text)

                        Else
                            .RefDate = #1/1/2014#
                        End If
                        .RefNo1 = txtReceiptRefNo1.Text 'D
                        .RefNo2 = txtReceiptRefNo2.Text 'D
                        .RefNo3 = txtReceiptRefNo3.Text 'D
                        .MainAccount = txtMainAcct.Text
                        '.OperatorId = "001"
                        .PostStatus = "U" 'Unposted
                        .ApprovalStatus = "N"
                        .RecordStatus = "A"
                        .Remarks = txtRemarks.Text
                        .SubAccount = txtSubAcct.Text
                        docMonth = Right(txtBatchDate.Text, 2)
                        docYear = Left(txtBatchDate.Text, 4)

                        If Trim(txtTellerDate.Text).Length > 0 Then
                            .TellerDate = ValidDate(txtTellerDate.Text)

                        Else
                            .TellerDate = #1/1/2014#
                        End If

                        .TellerNo = txtTellerNo.Text

                        If Trim(txtEffectiveDate.Text).Length > 0 Then
                            .TransDate = ValidDate(txtEffectiveDate.Text)

                        Else
                            .TransDate = #1/1/2014#
                        End If
                        .TransDescription = txtTransDesc.Text
                        .TransId = "D" 'Detail
                        .SerialNo = CType(txtSerialNo.Text, Long)
                        .DocNo = Trim(txtReceiptNo.Text)
                        .LedgerTypeCode = Trim(txtLedgerType.Text)
                        .TransMode = cmbMode.SelectedValue.ToString
                        swEntry = CType(Session("swEntry"), String)
                        If swEntry = "H" Or swEntry = "D" Then
                            swEntry = "D"
                            Session("swEntry") = swEntry
                            'get sub serial number
                            'L02, 002 -- for Sub serial number 
                            detailEdit = CType(Session("detailEdit"), String)
                            If detailEdit = "N" Then
                                Dim newSerialSubNum As String = gtRepo.GetNextSerialNumber("L02", "002", docMonth, docYear, " ", "12", "11")
                                txtSubSerialNo.Text = newSerialSubNum
                                .SubSerialNo = CType(txtSubSerialNo.Text, Integer)
                            End If
                        End If

                        prgKey = Session("prgKey")
                        If prgKey = "journal" Or prgKey = "JV" Then
                            .TransType = "JV"
                        ElseIf prgKey = "payment" Or prgKey = "PV" Then
                            .TransType = "PV"
                        Else
                            .TransType = "R"
                        End If

                        Cum_Detail_Amount = Cum_Detail_Amount + .GLAmountLC
                        Session("Cum_Detail_Amount") = Cum_Detail_Amount

                        ' If .PostStatus = "U" And .ApprovalStatus = "N" Then  'Unposted and Not Approved -- change is possible

                        gtRepo.Save(Gtrans)
                        msg = "Save Operation Successful"

                        lblError.Text = msg
                        lblError.Visible = True
                        publicMsgs = "javascript:alert('" + msg + "')"

                        'End If
                        grdData.DataBind()

                        Session("Gtrans") = Gtrans
                        initializeDetailFields()
                    End With


                End If
                ' initializeFields()


            End If
        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"

        End Try
    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub
    
    Private Sub fillValues()

        strKey = CType(Session("gtId"), String)
        gtRepo = CType(Session("gtRepo"), GLTransRepository)
        Gtrans = gtRepo.GetById(strKey)

        Session("Gtrans") = Gtrans
        If Gtrans IsNot Nothing Then
            With Gtrans
                txtBatchDate.Text = .BatchDate
                txtBatchNo.Text = .BatchNo
                cmbBranchCode.SelectedValue = .BranchCode
                txtChequeDate.Text = ValidDateFromDB(.ChequeDate)
                txtChequeNo.Text = .ChequeNo
                txtPayeeName.Text = .ClientName
                txtCompanyCode.Text = .CompanyCode
                cmbCurrencyType.SelectedValue = .CurrencyType
                cmbDept.SelectedValue = .DeptCode
                txtReceiptNo.Text = .DocNo
                txtEntryDate.Text = .EntryDate
                cmbTransDetailType.SelectedValue = .DetailTransType
                cmbDRCR.SelectedValue = .DRCR
                'txtTotalAmt.Text = Math.Round(.TotalAmt, 2)
                txtRefAmt.Text = Math.Round(.RefAmount, 2)
                txtRefDate.Text = ValidDateFromDB(.RefDate)
                txtReceiptRefNo1.Text = .RefNo1
                txtReceiptRefNo2.Text = .RefNo2
                txtReceiptRefNo3.Text = .RefNo3
                txtMainAcct.Text = .MainAccount
                '.OperatorId = "001"
                ' .PostStatus = "U" 'Unposted
                txtRemarks.Text = .Remarks
                txtSubAcct.Text = .SubAccount

                txtSubSerialNo.Text = .SubSerialNo
                txtTellerDate.Text = ValidDateFromDB(.TellerDate)
                txtTellerNo.Text = .TellerNo
                txtEffectiveDate.Text = ValidDateFromDB(.TransDate)
                txtTransDesc.Text = .TransDescription
                txtSerialNo.Text = .SerialNo
                txtReceiptNo.Text = .DocNo
                cmbTransType.SelectedValue = .TransType

                txtTransAmt.Text = Math.Round(.GLAmountLC, 2)

                cmbMode.SelectedValue = .TransMode
                txtLedgerType.Text = .LedgerTypeCode
                txtProgType.Text = CType(Session("prgKey"), String)

                Session("Gtrans") = Gtrans
            End With

            updateFlag = True
            Session("updateFlag") = updateFlag
            detailEdit = "Y"
            Session("detailEdit") = detailEdit
            grdData.DataBind()


        End If

    End Sub
    Protected Sub initializeFields()

        txtBatchDate.Text = String.Empty
        txtBatchNo.Text = String.Empty
        cmbBranchCode.SelectedIndex = 0
        txtChequeDate.Text = String.Empty
        txtChequeNo.Text = String.Empty
        txtPayeeName.Text = String.Empty
        txtCompanyCode.Text = "001"
        cmbCurrencyType.SelectedIndex = 0
        cmbDept.SelectedIndex = 0
        txtReceiptNo.Text = String.Empty
        txtTotalAmt.Text = String.Empty
        '.OperatorId = "001"
        '.PostStatus = "U" 'Unposted
        txtRemarks.Text = String.Empty
        txtTellerDate.Text = String.Empty
        txtTellerNo.Text = String.Empty
        txtEffectiveDate.Text = String.Empty
        txtTransDesc.Text = String.Empty
        txtSerialNo.Text = String.Empty
        txtReceiptNo.Text = String.Empty
        cmbMode.SelectedIndex = 0

        cmbTransDetailType.SelectedIndex = 0
        cmbDRCR.SelectedIndex = 1
        'txtRefAmt.Text = String.Empty
        txtRefDate.Text = String.Empty
        txtReceiptRefNo1.Text = String.Empty
        txtReceiptRefNo2.Text = String.Empty
        txtReceiptRefNo3.Text = String.Empty
        txtRefAmt.Text = 0.0
        txtMainAcct.Text = String.Empty
        txtSubAcct.Text = String.Empty
        txtSubAcctDesc.Text = String.Empty
        txtMainAcctDesc.Text = String.Empty
        txtLedgerType.Text = String.Empty
        txtTransAmt.Text = String.Empty


        txtSubSerialNo.Text = 0


        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record
        detailEdit = "N"
        Session("detailEdit") = detailEdit

        swEntry = "H"
        Session("swEntry") = swEntry

        prgKey = Session("prgKey")

    End Sub
    Protected Sub initializeDetailFields()

        cmbTransDetailType.SelectedIndex = 0
        cmbDRCR.SelectedIndex = 1
        txtRefAmt.Text = String.Empty
        txtRefDate.Text = String.Empty
        txtReceiptRefNo1.Text = String.Empty
        txtReceiptRefNo2.Text = String.Empty
        txtReceiptRefNo3.Text = String.Empty
        txtRefAmt.Text = 0.0
        txtMainAcct.Text = String.Empty
        txtSubAcct.Text = String.Empty
        txtSubAcctDesc.Text = String.Empty
        txtMainAcctDesc.Text = String.Empty
        txtLedgerType.Text = String.Empty

        txtSubSerialNo.Text = 0

        detailEdit = "N"
        Session("detailEdit") = detailEdit
        swEntry = "D"
        Session("swEntry") = swEntry
    End Sub
    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click, butDeleteDetail.Click
        Dim msg As String = String.Empty
        Gtrans = CType(Session("Gtrans"), CustodianLife.Model.GLTrans)
        gtRepo = CType(Session("gtRepo"), GLTransRepository)
        Try
            gtRepo.Delete(Gtrans)
            msg = "Delete Successful"
            lblError.Text = msg
            grdData.DataBind()

        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"
        End Try
        initializeDetailFields()



    End Sub

    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Dim msg As String = String.Empty

        Cum_Detail_Amount = CType(Session("Cum_Detail_Amount"), Decimal)
        Save_Amount = CType(Session("Save_Amount"), Decimal)


        'If (Save_Amount <> Cum_Detail_Amount) Then
        '    msg = "Total Amount " & Save_Amount & "is not equal to Detail Amounts!: " & Cum_Detail_Amount & "Pls Review before Closing"
        '    publicMsgs = "javascript:alert('" + msg + "')"

        '    Return 'do nothing
        'End If
        prgKey = Session("prgKey")

       
        Response.Redirect("ReceiptOthersList.aspx?prgKey=" & prgKey)
    End Sub

    Private Sub grdData_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdData.RowDataBound

        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim lblPrice As Label = CType(e.Row.FindControl("lblTransAmt"), Label)
            TransType = (DataBinder.Eval(e.Row.DataItem, "DRCR"))
            TransAmt = (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "GLAmountLC")))
            If TransType = "C" Then
                TransAmt = (TransAmt * -1)
            End If
            TotTransAmt = (TotTransAmt + TransAmt)

            End If
        If (e.Row.RowType = DataControlRowType.Footer) Then
            Dim lblTotal As Label = CType(e.Row.FindControl("lbltxtTotal"), Label)
            lblTotal.Text = Math.Round(TotTransAmt, 2).ToString
        End If

        'format fields
        Dim ea As GridViewRowEventArgs = CType(e, GridViewRowEventArgs)
        If (ea.Row.RowType = DataControlRowType.DataRow) Then
            Dim drv As GLTrans = CType(ea.Row.DataItem, GLTrans)
            ' Dim ob As Object = drv("GLAmountLC")
            If Not Convert.IsDBNull(drv.GLAmountLC) Then
                Dim iParsedValue As Decimal = 0
                If Decimal.TryParse(drv.GLAmountLC.ToString, iParsedValue) Then
                    Dim cell As TableCell = ea.Row.Cells(17)
                    cell.Text = String.Format(System.Globalization.CultureInfo.CurrentCulture, "{0:N}", New Object() {iParsedValue})
                End If
            End If
        End If
    End Sub

    Protected Sub butNew_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butNew.Click
        initializeFields()
    End Sub

    Protected Sub butNewDetail_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butNewDetail.Click
        initializeDetailFields()
    End Sub
    Private Function ValidDate(ByVal DateValue As String) As DateTime
        Dim dateparts() As String = DateValue.Split(Microsoft.VisualBasic.ChrW(47))
        Dim strDateTest As String = dateparts(1) & "/" & dateparts(0) & "/" & dateparts(2)
        Dim dateIn As Date = Format(CDate(strDateTest), "MM/dd/yyyy")
        Return dateIn
    End Function
    Private Function ValidDateFromDB(ByVal DateValue As Date) As String
        Dim dateparts() As String = DateValue.Date.ToString.Split(Microsoft.VisualBasic.ChrW(47))
        Dim strDateTest As String = dateparts(1) & "/" & dateparts(0) & "/" & Left(dateparts(2), 4)
        Return strDateTest
    End Function

    <System.Web.Services.WebMethod()> _
 Public Shared Function GetGrpDNoteInfo(ByVal _brokercode As String, ByVal _policynum As String, ByVal _transno As String) As String
        Dim polinfos As String = String.Empty
        Dim recRepo As New GLTransRepository()

        Try
            polinfos = recRepo.GetGroupDRNoteInfo(_brokercode, _policynum, _transno)
          
        Catch ex As ApplicationException

        Finally
            If polinfos = "<NewDataSet />" Then
                Throw New Exception()
            End If



        End Try
        Return polinfos
    End Function
    <System.Web.Services.WebMethod()> _
 Public Shared Function GetClaimsDNoteInfo(ByVal _brokercode As String, ByVal _claimsno As String, ByVal _transno As String) As String
        Dim cinfos As String = String.Empty
        Dim recRepo As New GLTransRepository()

        Try
            cinfos = recRepo.GetClaimsDRNoteInfo(_brokercode, _claimsno, _transno)

        Catch ex As ApplicationException

        Finally
            If cinfos = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try
        Return cinfos
    End Function
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetInvoiceInfo(ByVal _creditorcode As String, ByVal _invoiceno As String) As String
        Dim cinfos As String = String.Empty
        Dim recRepo As New GLTransRepository()

        Try
            cinfos = recRepo.GetInvoiceInfo(_creditorcode, _invoiceno)

        Catch ex As ApplicationException

        Finally
            If cinfos = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try


        Return cinfos
    End Function
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetBrokerInfo(ByVal _brokercode As String) As String
        Dim brkinfo As String = String.Empty
        Dim recRepo As New GLTransRepository()

        Try
            brkinfo = recRepo.GetBrokerInfo(_brokercode)

        Catch ex As ApplicationException

        Finally
            If brkinfo = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try


        Return brkinfo
    End Function

    Protected Sub csValidateCurrencyType_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles csValidateCurrencyType.ServerValidate

        If cmbCurrencyType.SelectedValue = "0" Then
            args.IsValid = False

        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If cmbDRCR.SelectedValue = "0" Then
            args.IsValid = False
        End If
    End Sub

    Protected Sub butPrintReceipt_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butPrintReceipt.Click
        Response.Redirect("prg_fin_recv_recpt_print.aspx?id=" & txtReceiptNo.Text)
    End Sub

    Protected Sub butPrint_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butPrint.Click

    End Sub

    Protected Sub grdData_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdData.SelectedIndexChanged

    End Sub
End Class