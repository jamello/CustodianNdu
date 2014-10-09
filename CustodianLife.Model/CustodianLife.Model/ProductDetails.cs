using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class ProductDetails
    {
        public virtual int? pdId { get; set; }
        public virtual string ProductDetailsModule { get; set; }
        public virtual string ProductCategory { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string ProductDesc { get; set; }
        public virtual string ProductPlanCode { get; set; }
        public virtual string ProductAgeCalc { get; set; }
        public virtual string ProductSAInstallType { get; set; }
        public virtual string ProductSAMultiple { get; set; }
        public virtual string ProductCommCode { get; set; }
        public virtual decimal ProductInstallPay1 { get; set; }
        public virtual decimal ProductInstallPeriod1 { get; set; }
        public virtual decimal ProductInstallPay2 { get; set; }
        public virtual decimal ProductInstallPeriod2 { get; set; }
        public virtual decimal ProductInstallPay3 { get; set; }
        public virtual decimal ProductInstallPeriod3 { get; set; }
        //public virtual ProductCoverDetails ProductCoverDetail { get; set; }

    }
}
