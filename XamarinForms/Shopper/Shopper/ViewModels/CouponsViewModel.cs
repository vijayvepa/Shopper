using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Threading.Tasks;
using Shopper.Business.Models;
using Shopper.Views;
using Xamarin.Forms;

namespace Shopper.ViewModels
{
    public class CouponsViewModel : BaseViewModel<CouponItem>
    {

        public CouponsViewModel()
        {
            MessagingCenter.Subscribe<NewCouponItemPage, CouponItem>(this, Messages.AddCouponItem, async (obj, item) =>
             {
                 var _item = item as CouponItem;
                 Items.Add(_item);
                 await DataStore.AddItemAsync(_item);
             });

        }


    }
}
