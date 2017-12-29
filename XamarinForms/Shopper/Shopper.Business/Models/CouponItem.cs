using System;
namespace Shopper.Business.Models
{
    public class CouponItem : BaseItem
    {
        public string Date { get; set; }

        public string Text { get; set; }

        public string Store { get; set; }

        public DateTime DateTime { get; set; }
    }
}
