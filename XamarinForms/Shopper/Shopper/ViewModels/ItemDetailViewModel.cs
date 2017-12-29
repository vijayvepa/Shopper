using System;
using Shopper.Business.Models;

namespace Shopper
{
    public class ItemDetailViewModel
    {
        public ShoppingItem Item { get; set; }
        public string Title { get; set; }

        public ItemDetailViewModel(ShoppingItem item = null)
        {
            Title = item?.Text;
            Item = item;
        }
    }
}
