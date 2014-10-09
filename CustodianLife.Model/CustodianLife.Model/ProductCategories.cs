using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class ProductCategories
    {
        public virtual int? pcId { get; set; }
        public virtual string ProductCatModule { get; set; }
        public virtual string ProductCatCode { get; set; }
        public virtual string ProductCatDesc { get; set; }
        public virtual string ProductCatShortDesc { get; set; }
    }
}
