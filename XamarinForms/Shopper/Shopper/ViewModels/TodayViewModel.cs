using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Threading.Tasks;
using Shopper.Business.Models;

using Xamarin.Forms;

namespace Shopper
{
    public class TodayViewModel : BaseViewModel<ShoppingItem>
    {
        


        public TodayViewModel()
        {
            Title = "Today";

            MessagingCenter.Subscribe<NewItemPage, ShoppingItem>(this, "AddItem", async (obj, item) =>
            {
                var _item = item as ShoppingItem;
                Items.Add(_item);
                await DataStore.AddItemAsync(_item);
            });


        }



    }
}
