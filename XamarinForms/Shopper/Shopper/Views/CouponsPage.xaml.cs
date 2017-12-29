using System;
using System.Collections.Generic;
using Shopper.Business.Models;
using Shopper.ViewModels;
using Xamarin.Forms;

namespace Shopper.Views
{
    public partial class CouponsPage : ContentPage
    {
        CouponsViewModel ViewModel;

        public CouponsPage()
        {
            InitializeComponent();
            BindingContext = ViewModel = new CouponsViewModel();
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

        async void Handle_CheckedChanged(object sender, object e)
        {
            await ViewModel.SaveItem(e as CouponItem);
        }

        async void AddItem_Clicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new NewCouponItemPage());
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();

            if (ViewModel.Items.Count == 0)
                ViewModel.LoadItemsCommand.Execute(null);
        }

        public async void OnDelete(object sender, EventArgs e)
        {
            var mi = ((MenuItem)sender);
            await ViewModel.DeleteItem(mi.CommandParameter as CouponItem);
        }
    }
}
