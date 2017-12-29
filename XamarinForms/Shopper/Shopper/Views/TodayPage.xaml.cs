using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.Models;

using Xamarin.Forms;

namespace Shopper
{
    public partial class TodayPage : ContentPage
    {
        
        TodayViewModel ViewModel;

        public TodayPage()
        {
            InitializeComponent();

            BindingContext = ViewModel = new TodayViewModel();
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
            await ViewModel.SaveItem(e as ShoppingItem);
        }

        async void AddItem_Clicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new NewItemPage());
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
            await ViewModel.DeleteItem(mi.CommandParameter as ShoppingItem);
        }
    }
}
