using System;
using Shopper.Business.Models;

namespace Shopper
{
    public class ItemDetailViewModel : BaseViewModel
    {
        public ShoppingItem Item { get; set; }
        public ItemDetailViewModel(ShoppingItem item = null)
        {
            Title = item?.Text;
            Item = item;
        }
    }
}
