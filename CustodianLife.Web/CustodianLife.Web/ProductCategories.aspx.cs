using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CustodianLife.Data;
using CustodianLife.Model;
using CustodianLife.Repositories;


namespace CustodianLife.Web
{
    public partial class ProductCategories : System.Web.UI.Page
    {
        ProductCatRepository pCatRepo;
        bool updateFlag;
        String strKey;
        CustodianLife.Model.ProductCategories prodCat = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pCatRepo = new  ProductCatRepository();
                Session["pCatRepo"] = pCatRepo;
                updateFlag = false;
                Session["updateFlag"] = updateFlag;

                strKey = Request.QueryString["idd"];
                if (strKey != null)
                {
                    fillValues();
                    Session["pcid"] = strKey;
                }

            }
            else
            {
                pCatRepo = (ProductCatRepository)Session["pCatRepo"];
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
                prodCat = new CustodianLife.Model.ProductCategories();
                lblError.Visible = false;

                prodCat.ProductCatModule = cmbModule.SelectedValue;
                prodCat.ProductCatCode= cmbCatCode.SelectedValue;
                prodCat.ProductCatDesc= txtCodeLongDesc.Text;
                prodCat.ProductCatShortDesc= txtCodeShortDesc.Text;

                pCatRepo.Save(prodCat);
                Session["prodCat"] = prodCat;

            }
            else
            {
                prodCat = (CustodianLife.Model.ProductCategories)Session["prodCat"];

                prodCat.ProductCatModule = cmbModule.SelectedValue;
                prodCat.ProductCatCode = cmbCatCode.SelectedValue;
                prodCat.ProductCatDesc = txtCodeLongDesc.Text;
                prodCat.ProductCatShortDesc = txtCodeShortDesc.Text;


                pCatRepo.Save(prodCat);
            }

            initializeFields();

        }
        protected void initializeFields()
        {
            cmbCatCode.SelectedIndex = 0;
            cmbModule.SelectedIndex = 0;
            txtCodeShortDesc.Text = String.Empty;
            txtCodeLongDesc.Text = String.Empty;
        }

        private void fillValues()
        {
            prodCat = pCatRepo.GetById(strKey);

            Session["prodCat"] = prodCat;
            if (prodCat != null)
            {

                txtCodeLongDesc.Text = prodCat.ProductCatDesc;
                txtCodeShortDesc.Text = prodCat.ProductCatShortDesc;
                cmbModule.SelectedValue = prodCat.ProductCatModule;
                cmbCatCode.SelectedValue = prodCat.ProductCatCode;
                updateFlag = true;
                Session["updateFlag"] = updateFlag;

            }
        }
    }
}
