using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.Models;

using Xamarin.Forms;

namespace Shopper
{
    public partial class TodayPage : ContentPage
    {
        async void Handle_CheckedChanged(object sender, object e) => await viewModel.SaveItem(e as ShoppingItem);

        TodayViewModel viewModel;

        public TodayPage()
        {
            InitializeComponent();

            BindingContext = viewModel = new TodayViewModel();
        }

        async void OnItemSelected(object sender, SelectedItemChangedEventArgs args)
        {
            var item = args.SelectedItem as ShoppingItem;
            if (item == null)
                return;

            await Navigation.PushAsync(new ItemDetailPage(new ItemDetailViewModel(item)));

            // Manually deselect item
            ItemsListView.SelectedItem = null;
        }

        async void AddItem_Clicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new NewItemPage());
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();

            if (viewModel.Items.Count == 0)
                viewModel.LoadItemsCommand.Execute(null);
        }

        public void OnMore(object sender, EventArgs e)
        {
            var mi = ((MenuItem)sender);
            DisplayAlert("More Context Action", mi.CommandParameter + " more context action", "OK");
        }

        public async void OnDelete(object sender, EventArgs e)
        {
            var mi = ((MenuItem)sender);
            await viewModel.DeleteItem(mi.CommandParameter as ShoppingItem);
        }
    }
}
