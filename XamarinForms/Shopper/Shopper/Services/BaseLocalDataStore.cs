using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.LocalStorage;
using Shopper.Business.Models;

namespace Shopper.Services
{
    public class BaseLocalDataStore<TItem> : IDataStore<TItem> where TItem: BaseItem, new()
    {
        BaseDatabase<TItem> Database { get; set; }

        public BaseLocalDataStore(BaseDatabase<TItem> database)
        {
            Database = database;
        }

        public async Task<bool> AddItemAsync(TItem item)
        {
            var result = await Database.SaveItemAsync(item);
            item.Id = result;

            return true;
        }

        public async Task<bool> UpdateItemAsync(TItem item)
        {
            await Database.SaveItemAsync(item);
            return true;
        }

        public Task<bool> DeleteItemAsync(TItem item)
        {
            Database.DeleteItemAsync(item);
            return Task.FromResult(true);
        }

        public Task<TItem> GetItemAsync(string id)
        {
            return Database.GetItemAsync(id);
        }

        public Task<List<TItem>> GetItemsAsync(bool forceRefresh = false)
        {
            return Database.GetItemsAsync();
        }
    }
}
