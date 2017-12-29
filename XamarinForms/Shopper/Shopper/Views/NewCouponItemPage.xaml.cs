using System;
using System.Collections.Generic;
using Shopper.Business;
using Xamarin.Forms;

namespace Shopper.Views
{
    public partial class NewCouponItemPage : ContentPage
    {
        public string CouponText { get; set; }

        public NewCouponItemPage()
        {
            InitializeComponent();
            BindingContext = this;
        }

        async void Save_Clicked(object sender, EventArgs e)
        {
            var items = ShoppingItemsParser.ParseCoupons(CouponText);

            foreach (var item in items)
            {
                MessagingCenter.Send(this, Messages.AddCouponItem, item);
            }
            await Navigation.PopAsync();
        }
    }
}
