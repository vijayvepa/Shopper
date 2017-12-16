using System;

namespace Shopper
{
    public class ShoppingItem
    {
        public ShoppingItem()
        {
            Date = DateTime.Now;
        }

        public string Id { get; set; }
        public string Text { get; set; }
        public string Store { get; set; }
        public bool Done { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
    }
}
