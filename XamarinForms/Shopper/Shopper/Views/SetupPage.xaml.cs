using System;
using Shopper.Business.Models;
using Shopper.ViewModels;
using Xamarin.Forms;

namespace Shopper
{
    public partial class SetupPage : ContentPage
    {
        public SetupPage()
        {
            InitializeComponent();
            BindingContext = new SetupViewModel();
        }

        async void OnItemSelected(object sender, SelectedItemChangedEventArgs args)
        {
            var item = args.SelectedItem as SetupItem;
            if (item == null)
                return;

            var targetPage = Activator.CreateInstance(item.Target) as Page;

            await Navigation.PushAsync(targetPage);

            // Manually deselect item
            ItemsListView.SelectedItem = null;
        }

    }
}
