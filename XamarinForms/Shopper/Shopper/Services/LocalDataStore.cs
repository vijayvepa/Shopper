using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.LocalStorage;
using Shopper.Business.Models;
using Shopper.Services;
using Xamarin.Forms;

[assembly: Dependency(typeof(LocalDataStore))]
namespace Shopper.Services
{
    public class LocalDataStore : IDataStore<ShoppingItem>
    {
        

        public Task<bool> AddItemAsync(ShoppingItem item)
        {
           
            DatabaseProvider.Database.SaveItemAsync(item);
            return Task.FromResult(true);
        }

        public Task<bool> UpdateItemAsync(ShoppingItem item)
        {
            DatabaseProvider.Database.SaveItemAsync(item);
            return Task.FromResult(true);
        }

        public Task<bool> DeleteItemAsync(int id)
        {
            var item = DatabaseProvider.Database.GetItemAsync(id);
            if (item.Result != null)
            {
                DatabaseProvider.Database.DeleteItemAsync(item.Result);
                return Task.FromResult(true);
            }

            return Task.FromResult(false);
        }

        public Task<ShoppingItem> GetItemAsync(int id)
        {
            return DatabaseProvider.Database.GetItemAsync(id);
        }

        public Task<List<ShoppingItem>> GetItemsAsync(bool forceRefresh = false)
        {
            return DatabaseProvider.Database.GetItemsAsync();
        }
    }
}
