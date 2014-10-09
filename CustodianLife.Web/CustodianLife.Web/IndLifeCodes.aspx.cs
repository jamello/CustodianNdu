using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CustodianLife.Data;
using CustodianLife.Model;
using CustodianLife.Repositories;

namespace CustodianLife.Web
{
    public partial class IndLifeCodes : System.Web.UI.Page
    {
        IndLifeCodesRepository indRepo;
        bool updateFlag;
        String strKey;
        CustodianLife.Model.IndLifeCodes indlife = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                indRepo = new IndLifeCodesRepository();
                Session["indRepo"] = indRepo;
                updateFlag = false;
                Session["updateFlag"] = updateFlag;
    
                strKey = Request.QueryString["idd"];
                if (strKey != null)
                {
                    fillValues();
                    Session["qid"] = strKey;
                }

            }
            else
            {
                indRepo = (IndLifeCodesRepository)Session["indRepo"];
            }

        }

        protected void butSave_Click(object sender, EventArgs e)
        {
            //this routine will persist only one object. 
            //1. The indlifecodes object

            updateFlag = (bool)Session["updateFlag"];


            if (!updateFlag) //if new record
            {
                //create a new instance of the indlifecode object
                indlife =  new  CustodianLife.Model.IndLifeCodes();
                lblError.Visible = false;
               
                indlife.CodeItem = txtCodeItem.Text;
                indlife.CodeLongDesc = txtCodeLongDesc.Text;
                indlife.CodeShortDesc = txtCodeShortDesc.Text;
                indlife.CodeTabId = cmbCodeID.SelectedValue;
                indlife.CodeType = txtCodeType.Text;

                indRepo.Save(indlife);
                Session["indlife"] = indlife;

             }
            else
            {
                indlife = (CustodianLife.Model.IndLifeCodes)Session["indlife"];

                indlife.CodeItem = txtCodeItem.Text;
                indlife.CodeLongDesc = txtCodeLongDesc.Text;
                indlife.CodeShortDesc = txtCodeShortDesc.Text;
                indlife.CodeTabId = cmbCodeID.SelectedValue;
                indlife.CodeType = txtCodeType.Text;


                indRepo.Save(indlife);
            }

            initializeFields();

        }
        protected void initializeFields()
        {
            cmbCodeID.SelectedIndex = 0;
            txtCodeType.Text = String.Empty;
            txtCodeShortDesc.Text = String.Empty;
            txtCodeLongDesc.Text = String.Empty;
        }

        private void fillValues()
        {
            //IList dt = new ArrayList();
            indlife = indRepo.GetById(strKey);

            Session["indlife"] = indlife;
            if (indlife != null)
            {

                txtCodeLongDesc.Text = indlife.CodeLongDesc;
                txtCodeShortDesc.Text = indlife.CodeShortDesc;
                txtCodeType.Text = indlife.CodeType;
                txtCodeItem.Text = indlife.CodeItem;
                cmbCodeID.SelectedValue = indlife.CodeTabId;
                updateFlag = true;
                Session["updateFlag"] = updateFlag;

            }
        }
    }
}
