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

Partial Public Class PRG_FIN_CREDITORS_ENTRY
    Inherits System.Web.UI.Page

    Dim invRepo As InvoiceRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim transTypeEnq As TransactionTypesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim prgKey As String
    Dim Save_Amount As Decimal = 0
    Dim Cum_Detail_Amount As Decimal = 0
    Dim InvTrans As CustodianLife.Model.Invoice
    Dim TotTransAmt As Decimal = 0
    Dim TransAmt As Decimal = 0
    Dim newDocRefNo As String


    Protected publicMsgs As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            invRepo = New InvoiceRepository
            indLifeEnq = New IndLifeCodesRepository
            transTypeEnq = New TransactionTypesRepository

            Session("invRepo") = invRepo
            updateFlag = False
            Session("updateFlag") = updateFlag
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


            SetComboBinding(cmbBranchCode, indLifeEnq.GetById("L02", "003"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbDept, indLifeEnq.GetById("L02", "005"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbTransDetailType, transTypeEnq.TransactionTypesDetails, "Description", "TransactionCode")

            cmbTransType.Attributes.Add("readonly", "readonly")

            If strKey IsNot Nothing Then
                fillValues()
            Else
                invRepo = CType(Session("invRepo"), InvoiceRepository)
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



        End If


    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSaveDetail.Click
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
                    InvTrans = New CustodianLife.Model.Invoice()
                    invRepo = New InvoiceRepository()
                    lblError.Visible = False

                    With InvTrans
                        .BatchDate = CType(txtBatchDate.Text, Integer)
                        .BatchNo = CType(txtBatchNo.Text, Integer)
                        .BranchCode = cmbBranchCode.SelectedValue.ToString()
                        .CompanyCode = txtCompanyCode.Text
                        .DeptCode = cmbDept.SelectedValue.ToString()
                        .InvoiceNo = txtReceiptNo.Text
                        .EntryDate = Now.Date

                        .OperatorId = "001"
                        .PostStatus = "U" 'Unposted
                        .ApprovalStatus = "N"
                        .Flag = "A"
                        .Price = txtPrice.Text
                        .Quantity = txtQty.Text
                        .MainAccountDR = txtMainAcct.Text
                        .SubAccountDR = txtSubAcct.Text

                        .TransDate = CType(txtEffectiveDate.Text, Date)
                        .TransDescription = txtTransDesc.Text
                        .TransType = cmbTransType.SelectedValue.ToString()
                        Session("Save_Amount") = Save_Amount

                        Cum_Detail_Amount = 0
                        Session("Cum_Detail_Amount") = Cum_Detail_Amount

                        docMonth = Right(txtBatchDate.Text, 2)
                        docYear = Left(txtBatchDate.Text, 4)
                        'get new serial number
                        'L03(Invoices) , 001 -- for main serial number 
                        Dim newSerialNum As String = invRepo.GetNextSerialNumber("L03", "001", docMonth, docYear, " ", "12", "11")

                        prgKey = Session("prgKey")
                        .TransType = "INV"
                        'get new INVOICE number
                        newDocRefNo = invRepo.GetNextSerialNumber("INV", _
                                                                 "001", _
                                                                 "001", _
                                                               docYear, _
                                                              "INV/", _
                                                                  "13", _
                                                                   "12")
                        txtReceiptNo.Text = newDocRefNo
                        txtSerialNo.Text = newSerialNum
                        .SerialNo = CType(txtSerialNo.Text, Long)
                        .InvoiceNo = Trim(txtReceiptNo.Text)

                        .DRCR = String.Empty 'D
                        .TransAmt = txtTransAmt.Text
                        If Trim(txtRefDate.Text).Length() > 0 Then
                            .RefDate = CType(txtRefDate.Text, Date)
                        Else
                            .RefDate = #1/1/2014#
                        End If

                        .CreditorCode = txtReceiptRefNo1.Text

                        'save
                        invRepo.Save(InvTrans)
                        grdData.DataBind()
                        Session("InvTrans") = InvTrans
                        updateFlag = True
                        Session("updateFlag") = updateFlag
                    End With
                Else
                    InvTrans = CType(Session("InvTrans"), CustodianLife.Model.Invoice)
                End If
                invRepo = CType(Session("invRepo"), InvoiceRepository)


                With InvTrans
                    .BatchDate = CType(txtBatchDate.Text, Integer)
                    .BatchNo = CType(txtBatchNo.Text, Integer)
                    .BranchCode = cmbBranchCode.SelectedValue.ToString()
                    .CompanyCode = txtCompanyCode.Text
                    .DeptCode = cmbDept.SelectedValue.ToString()
                    .InvoiceNo = txtReceiptNo.Text
                    .EntryDate = Now.Date

                    .MainAccountDR = txtMainAcct.Text
                    .OperatorId = "001"
                    .PostStatus = "U" 'Unposted
                    .ApprovalStatus = "N"
                    .Flag = "A"
                    .Price = txtPrice.Text
                    .Quantity = txtQty.Text
                    .MainAccountDR = txtMainAcct.Text
                    .SubAccountDR = txtSubAcct.Text

                    .TransDate = CType(txtEffectiveDate.Text, Date)
                    .TransDescription = txtTransDesc.Text
                    .TransType = cmbTransType.SelectedValue.ToString()
                    .EntryDate = Now.Date
                    docMonth = Right(txtBatchDate.Text, 2)
                    docYear = Left(txtBatchDate.Text, 4)
                    .TransDescription = txtTransDesc.Text
                    .SerialNo = CType(txtSerialNo.Text, Long)
                    .InvoiceNo = Trim(txtReceiptNo.Text)
                    '.LedgerTypeCode = Trim(txtLedgerType.Text)


                    ' If .PostStatus = "U" And .ApprovalStatus = "N" Then  'Unposted and Not Approved -- change is possible

                    invRepo.Save(InvTrans)
                    msg = "Save Operation Successful"

                    lblError.Text = msg
                    lblError.Visible = True
                    publicMsgs = "javascript:alert('" + msg + "')"

                    'End If
                    grdData.DataBind()

                    Session("InvTrans") = InvTrans
                    initializeFields()
                End With


            End If
            ' initializeFields()


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
        invRepo = CType(Session("invRepo"), InvoiceRepository)
        InvTrans = invRepo.GetById(strKey)

        Session("InvTrans") = InvTrans
        If InvTrans IsNot Nothing Then
            With InvTrans
                txtBatchDate.Text = .BatchDate
                txtBatchNo.Text = .BatchNo
                cmbBranchCode.SelectedValue = .BranchCode
                txtCompanyCode.Text = .CompanyCode
                cmbDept.SelectedValue = .DeptCode
                txtReceiptNo.Text = .InvoiceNo
                txtEntryDate.Text = .EntryDate
                txtRefDate.Text = .RefDate
                'txtReceiptRefNo1.Text = .RefNo1
                txtMainAcct.Text = .MainAccountDR
                '.OperatorId = "001"
                ' .PostStatus = "U" 'Unposted
                'txtRemarks.Text = .Remarks
                txtSubAcct.Text = .SubAccountDR

                txtEffectiveDate.Text = .TransDate
                txtTransDesc.Text = .TransDescription
                txtSerialNo.Text = .SerialNo
                cmbTransType.SelectedValue = .TransType

                txtTransAmt.Text = Math.Round(.TransAmt, 2)
                'txtLedgerType.Text = .LedgerTypeCode
                txtProgType.Text = CType(Session("prgKey"), String)

                Session("InvTrans") = InvTrans
            End With

            updateFlag = True
            Session("updateFlag") = updateFlag
            grdData.DataBind()


        End If

    End Sub
    Protected Sub initializeFields()

        txtBatchDate.Text = String.Empty
        txtBatchNo.Text = String.Empty
        cmbBranchCode.SelectedIndex = 0
        txtPrice.Text = String.Empty
        txtCompanyCode.Text = "001"
        cmbDept.SelectedIndex = 0
        txtReceiptNo.Text = String.Empty
        '.OperatorId = "001"
        '.PostStatus = "U" 'Unposted
        'txtRemarks.Text = String.Empty
        txtEffectiveDate.Text = String.Empty
        txtTransDesc.Text = String.Empty
        txtSerialNo.Text = String.Empty
        txtReceiptNo.Text = String.Empty

        cmbTransDetailType.SelectedIndex = 0
        'txtRefAmt.Text = String.Empty
        txtRefDate.Text = String.Empty
        'txtReceiptRefNo1.Text = String.Empty
        txtRefAmt.Text = 0.0
        txtMainAcct.Text = String.Empty
        txtSubAcct.Text = String.Empty
        txtSubAcctDesc.Text = String.Empty
        txtMainAcctDesc.Text = String.Empty
        'txtLedgerType.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

    End Sub
    

    Protected Sub butDeleteDetail_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDeleteDetail.Click
        Dim msg As String = String.Empty
        InvTrans = CType(Session("InvTrans"), CustodianLife.Model.Invoice)
        invRepo = CType(Session("invRepo"), InvoiceRepository)
        Try
            invRepo.Delete(InvTrans)
            msg = "Delete Successful"
            lblError.Text = msg
            grdData.DataBind()

        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"
        End Try
        initializeFields()

    End Sub

    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Dim msg As String = String.Empty

        Cum_Detail_Amount = CType(Session("Cum_Detail_Amount"), Decimal)
        Save_Amount = CType(Session("Save_Amount"), Decimal)


        If (Save_Amount <> Cum_Detail_Amount) Then
            msg = "Total Amount " & Save_Amount & "is not equal to Detail Amounts!: " & Cum_Detail_Amount & "Pls Review before Closing"
            publicMsgs = "javascript:alert('" + msg + "')"

            Return 'do nothing
        End If

        Response.Redirect("ReceiptOthersList.aspx")

    End Sub

   
    Protected Sub txtQty_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtQty.TextChanged

    End Sub
End Class