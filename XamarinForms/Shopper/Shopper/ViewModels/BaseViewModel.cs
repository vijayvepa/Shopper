using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Shopper.Business.Models;

using Xamarin.Forms;

namespace Shopper
{
    public class BaseViewModel<TItem> : INotifyPropertyChanged
    {
        public IDataStore<TItem> DataStore => DependencyService.Get<IDataStore<TItem>>();
        public ObservableCollection<TItem> Items { get; set; }
        public Command LoadItemsCommand { get; set; }
        private bool IsLoaded { get; set; }

        public BaseViewModel()
        {
            Items = new ObservableCollection<TItem>();
            LoadItemsCommand = new Command(async () => await ExecuteLoadItemsCommand());
        }

        bool isBusy = false;
        public bool IsBusy
        {
            get { return isBusy; }
            set { SetProperty(ref isBusy, value); }
        }

        string title = string.Empty;
        public string Title
        {
            get { return title; }
            set { SetProperty(ref title, value); }
        }

        protected bool SetProperty<T>(ref T backingStore, T value,
            [CallerMemberName]string propertyName = "",
            Action onChanged = null)
        {
            if (EqualityComparer<T>.Default.Equals(backingStore, value))
                return false;

            backingStore = value;
            onChanged?.Invoke();
            OnPropertyChanged(propertyName);
            return true;
        }

        #region INotifyPropertyChanged
        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string propertyName = "")
        {
            var changed = PropertyChanged;
            if (changed == null)
                return;

            changed.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
        #endregion


        public async Task SaveItem(TItem item)
        {
            await DataStore.UpdateItemAsync(item);
        }

        public async Task DeleteItem(TItem item)
        {
            await DataStore.DeleteItemAsync(item);
            Items.Remove(item);
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
