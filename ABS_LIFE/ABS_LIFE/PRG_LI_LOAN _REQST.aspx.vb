Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_LOAN__REQST
    Inherits System.Web.UI.Page
    Dim ldisRepo As LoanDisbursementRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim prodEnq As ProductDetailsRepository
    Dim loanREnq As LoanInterestRepository

    Dim updateFlag As Boolean
    Dim strKey As String
    Dim LoanDisb As CustodianLife.Model.LoanDisbursement
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ldisRepo = New LoanDisbursementRepository
            indLifeEnq = New IndLifeCodesRepository
            loanREnq = New LoanInterestRepository
            prodEnq = New ProductDetailsRepository

            Session("ldisRepo") = ldisRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("Intid") = strKey

            ' Dim lstLifeCodes As IList = CType(indLifeEnq.GetById("L01", "017"), IList) 'these are codes for loan interests rate
            SetComboBinding(cmbLoanCodeID, indLifeEnq.GetById("L01", "018"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbProductCode, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")
            SetComboBinding(cmbInterestRate, loanREnq.LoanInterestRates(), "LoanInterestRate", "LoanCode")

            If strKey IsNot Nothing Then
                fillValues()
            Else
                ldisRepo = CType(Session("ldisRepo"), LoanDisbursementRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click

        'this routine will persist only one object. 
        '1. The Loan Disbursement object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the LoanDisbcode object
            LoanDisb = New CustodianLife.Model.LoanDisbursement()
            ldisRepo = New LoanDisbursementRepository()
            lblError.Visible = False

            LoanDisb.LoanCode = cmbLoanCodeID.SelectedValue
            LoanDisb.FirstInstallAmountFC = CType(txtFirstInstalAmtFC.Text, Decimal)
            LoanDisb.FirstInstallAmountLC = CType(txtFirstInstalAmtLC.Text, Decimal)
            LoanDisb.LoanAmtGrantedFC = CType(txtAmtGrantedFC.Text, Decimal)
            LoanDisb.LoanAmtGrantedLC = CType(txtAmtGrantedLC.Text, Decimal)
            LoanDisb.LoanDisbursementChargeFC = CType(txtDisbursementChargeFC.Text, Decimal)
            LoanDisb.LoanDisbursementChargeLC = CType(txtDisbursementChargeLC.Text, Decimal)
            LoanDisb.LoanInterestAmtFC = CType(txtInterestAmtFC.Text, Decimal)
            LoanDisb.LoanInterestAmtLC = CType(txtInterestAmtLC.Text, Decimal)
            LoanDisb.LoanInterestRate = CType(cmbInterestRate.SelectedValue, Decimal)
            LoanDisb.LoanMaxAmountForeign = CType(txtMaximumAmtForeign.Text, Decimal)
            LoanDisb.LoanMaxAmountLocal = CType(txtMaximumAmtLocal.Text, Decimal)
            LoanDisb.LoanRepayFrequency = cmbRepaymentFreq.SelectedValue
            LoanDisb.NumberOfInstallment = CType(txtRepayNoOfInstal.Text, Int16)
            LoanDisb.PolicyNumber = txtPolicyNo.Text.ToString()
            LoanDisb.ReferenceNo = CType(txtRefNo.Text, Int32)
            LoanDisb.RepaymentAmountFC = CType(txtRepaymentAmtFC.Text, Decimal)
            LoanDisb.RepaymentAmountLC = CType(txtRepaymentAmtLC.Text, Decimal)
            LoanDisb.RepaymentStartDate = CType(txtStartDate.Text, Date)
            LoanDisb.RequestDate = CType(txtLoanRequestDate.Text, Date)

            ldisRepo.Save(LoanDisb)
            Session("LoanDisb") = LoanDisb
        Else
            LoanDisb = CType(Session("LoanDisb"), CustodianLife.Model.LoanDisbursement)
            ldisRepo = CType(Session("ldisRepo"), LoanDisbursementRepository)


            LoanDisb.LoanCode = cmbLoanCodeID.SelectedValue
            LoanDisb.FirstInstallAmountFC = CType(txtFirstInstalAmtFC.Text, Decimal)
            LoanDisb.FirstInstallAmountLC = CType(txtFirstInstalAmtLC.Text, Decimal)
            LoanDisb.LoanAmtGrantedFC = CType(txtAmtGrantedFC.Text, Decimal)
            LoanDisb.LoanAmtGrantedLC = CType(txtAmtGrantedLC.Text, Decimal)
            LoanDisb.LoanDisbursementChargeFC = CType(txtDisbursementChargeFC.Text, Decimal)
            LoanDisb.LoanDisbursementChargeLC = CType(txtDisbursementChargeLC.Text, Decimal)
            LoanDisb.LoanInterestAmtFC = CType(txtInterestAmtFC.Text, Decimal)
            LoanDisb.LoanInterestAmtLC = CType(txtInterestAmtLC.Text, Decimal)
            LoanDisb.LoanInterestRate = CType(cmbInterestRate.SelectedValue, Decimal)
            LoanDisb.LoanMaxAmountForeign = CType(txtMaximumAmtForeign.Text, Decimal)
            LoanDisb.LoanMaxAmountLocal = CType(txtMaximumAmtLocal.Text, Decimal)
            LoanDisb.LoanRepayFrequency = cmbRepaymentFreq.SelectedValue
            LoanDisb.NumberOfInstallment = CType(txtRepayNoOfInstal.Text, Int16)
            LoanDisb.PolicyNumber = txtPolicyNo.Text.ToString()
            LoanDisb.ReferenceNo = CType(txtRefNo.Text, Int32)
            LoanDisb.RepaymentAmountFC = CType(txtRepaymentAmtFC.Text, Decimal)
            LoanDisb.RepaymentAmountLC = CType(txtRepaymentAmtLC.Text, Decimal)
            LoanDisb.RepaymentStartDate = CType(txtStartDate.Text, Date)
            LoanDisb.RequestDate = CType(txtLoanRequestDate.Text, Date)
            ldisRepo.Save(LoanDisb)

        End If

        initializeFields()
    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub
    Private Sub fillValues()

        strKey = CType(Session("Intid"), String)
        ldisRepo = CType(Session("ldisRepo"), LoanDisbursementRepository)
        LoanDisb = ldisRepo.GetById(strKey)

        Session("LoanDisb") = LoanDisb
        If LoanDisb IsNot Nothing Then
            cmbLoanCodeID.SelectedValue = LoanDisb.LoanCode

            txtFirstInstalAmtFC.Text = LoanDisb.FirstInstallAmountFC
            txtFirstInstalAmtLC.Text = LoanDisb.FirstInstallAmountLC
            txtAmtGrantedFC.Text = LoanDisb.LoanAmtGrantedFC
            txtAmtGrantedLC.Text = LoanDisb.LoanAmtGrantedLC
            txtDisbursementChargeFC.Text = LoanDisb.LoanDisbursementChargeFC
            txtDisbursementChargeLC.Text = LoanDisb.LoanDisbursementChargeLC
            txtInterestAmtFC.Text = LoanDisb.LoanInterestAmtFC
            txtInterestAmtLC.Text = LoanDisb.LoanInterestAmtLC
            cmbInterestRate.SelectedValue = LoanDisb.LoanInterestRate
            txtMaximumAmtForeign.Text = LoanDisb.LoanMaxAmountForeign
            txtMaximumAmtLocal.Text = LoanDisb.LoanMaxAmountLocal
            cmbRepaymentFreq.SelectedValue = LoanDisb.LoanRepayFrequency
            txtRepayNoOfInstal.Text = LoanDisb.NumberOfInstallment
            txtPolicyNo.Text = LoanDisb.PolicyNumber
            txtRefNo.Text = LoanDisb.ReferenceNo
            txtRepaymentAmtFC.Text = LoanDisb.RepaymentAmountFC
            txtRepaymentAmtLC.Text = LoanDisb.RepaymentAmountLC
            txtStartDate.Text = LoanDisb.RepaymentStartDate
            txtLoanRequestDate.Text = LoanDisb.RequestDate
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbLoanCodeID.SelectedIndex = 0

        txtFirstInstalAmtFC.Text = String.Empty
        txtFirstInstalAmtLC.Text = String.Empty
        txtAmtGrantedFC.Text = String.Empty
        txtAmtGrantedLC.Text = String.Empty
        txtDisbursementChargeFC.Text = String.Empty
        txtDisbursementChargeLC.Text = String.Empty
        txtInterestAmtFC.Text = String.Empty
        txtInterestAmtLC.Text = String.Empty
        cmbInterestRate.SelectedIndex = 0
        txtMaximumAmtForeign.Text = String.Empty
        txtMaximumAmtLocal.Text = String.Empty
        cmbRepaymentFreq.SelectedIndex = 0
        txtRepayNoOfInstal.Text = String.Empty
        txtPolicyNo.Text = String.Empty
        txtRefNo.Text = String.Empty
        txtRepaymentAmtFC.Text = String.Empty
        txtRepaymentAmtLC.Text = String.Empty
        txtStartDate.Text = String.Empty
        txtLoanRequestDate.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub


    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        LoanDisb = CType(Session("LoanDisb"), CustodianLife.Model.LoanDisbursement)
        ldisRepo = CType(Session("ldisRepo"), LoanDisbursementRepository)
        ldisRepo.Delete(LoanDisb)
        initializeFields()

    End Sub
End Class