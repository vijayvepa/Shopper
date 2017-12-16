using System;

using Xamarin.Forms;

namespace Shopper
{
    public partial class NewItemPage : ContentPage
    {
        public ShoppingItem Item { get; set; }

        public NewItemPage()
        {
            InitializeComponent();

            Item = new ShoppingItem
            {
                Text = "Item name",
                Description = "This is an item description."
            };

            BindingContext = this;
        }

        async void Save_Clicked(object sender, EventArgs e)
        {
            MessagingCenter.Send(this, "AddItem", Item);
            await Navigation.PopToRootAsync();
        }
    }
}
