using System;
using SQLite;

namespace Shopper.Business.Models
{
    public class ShoppingItem : BaseItem
    {
        public ShoppingItem()
        {
            Date = DateTime.Now;
        }

       
        public string Text { get; set; }
        public string Store { get; set; }
        public bool Done { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
    }
}
