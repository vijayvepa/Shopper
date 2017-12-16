using System;
using Shopper.Business;
using Shopper.Business.Models;
using Xamarin.Forms;

namespace Shopper
{
    public partial class NewItemPage : ContentPage
    {
        public string ShoppingText { get; set; }


        public NewItemPage()
        {
            InitializeComponent();

            BindingContext = this;
        }

        async void Save_Clicked(object sender, EventArgs e)
        {
            var items = ShoppingItemsParser.Parse(ShoppingText);

            foreach (var item in items)
            {
                MessagingCenter.Send(this, "AddItem", item);
            }
            await Navigation.PopToRootAsync();
        }
    }
}
