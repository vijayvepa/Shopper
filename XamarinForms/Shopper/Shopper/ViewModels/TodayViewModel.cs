using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Threading.Tasks;

using Xamarin.Forms;

namespace Shopper
{
    public class TodayViewModel : BaseViewModel
    {
        public ObservableCollection<ShoppingItem> Items { get; set; }
        public Command LoadItemsCommand { get; set; }
        private bool IsLoaded { get; set; }

        public TodayViewModel()
        {
            Title = "Today";
            Items = new ObservableCollection<ShoppingItem>();
            LoadItemsCommand = new Command(async () => await ExecuteLoadItemsCommand());

            MessagingCenter.Subscribe<NewItemPage, ShoppingItem>(this, "AddItem", async (obj, item) =>
            {
                var _item = item as ShoppingItem;
                Items.Add(_item);
                await DataStore.AddItemAsync(_item);
            });
        }

        async Task ExecuteLoadItemsCommand()
        {
            if (IsLoaded && IsBusy)
                return;

            IsBusy = true;

            try
            {
                Items.Clear();
                var items = await DataStore.GetItemsAsync(true);
                foreach (var item in items)
                {
                    Items.Add(item);
                }
                IsLoaded = true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
            }
            finally
            {
                IsBusy = false;
            }
        }
    }
}
