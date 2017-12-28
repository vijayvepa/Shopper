using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Shopper.Business.Models;
using Shopper.Views;
using Xamarin.Forms;

namespace Shopper.ViewModels
{
    public class SetupViewModel
    {
        public List<SetupItem> Items { get; set; }

        public SetupViewModel()
        {
            Items = new List<SetupItem>(){
                new SetupItem(){ Text="Coupons" , Target = typeof(CouponsPage)},
                new SetupItem(){ Text="Returns" , Target = typeof(ReturnsPage)},
                new SetupItem(){ Text="Sharing" , Target = typeof(SharingPage)},
                new SetupItem(){ Text="About", Target = typeof(AboutPage)}
            };
        }
    }
}

