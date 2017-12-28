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
        public async Task<bool> AddItemAsync(ShoppingItem item)
        {
            var result = await DatabaseProvider.Database.SaveItemAsync(item);
            item.Id = result;

            return true;
        }

        public async Task<bool> UpdateItemAsync(ShoppingItem item)
        {
            await DatabaseProvider.Database.SaveItemAsync(item);
            return true;
        }

        public Task<bool> DeleteItemAsync(ShoppingItem item)
        {
            DatabaseProvider.Database.DeleteItemAsync(item);
            return Task.FromResult(true);
        }

        public Task<ShoppingItem> GetItemAsync(string id)
        {
            return DatabaseProvider.Database.GetItemAsync(id);
        }

        public Task<List<ShoppingItem>> GetItemsAsync(bool forceRefresh = false)
        {
            return DatabaseProvider.Database.GetItemsAsync();
        }
    }
}
