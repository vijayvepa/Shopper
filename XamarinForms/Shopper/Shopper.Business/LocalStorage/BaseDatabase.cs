using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.Models;
using SQLite;

namespace Shopper.Business.LocalStorage
{
    public class BaseDatabase<TItem> where TItem : BaseItem, new()
    {
        private SQLiteAsyncConnection Database { get; set; }

        public BaseDatabase(string dbPath)
        {
            Database = new SQLiteAsyncConnection(dbPath);
            Database.CreateTableAsync<TItem>().Wait();
        }

        public Task<List<TItem>> GetItemsAsync()
        {
            return Database.Table<TItem>().ToListAsync();
        }

        public Task<TItem> GetItemAsync(string id)
        {
            return Database.Table<TItem>().Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<string> SaveItemAsync(TItem item)
        {
            if (!string.IsNullOrWhiteSpace(item.Id))
            {
                await Database.UpdateAsync(item);
                return item.Id;
            }
            else
            {
                item.Id = Guid.NewGuid().ToString();
                await Database.InsertAsync(item);
                return item.Id;
            }
        }

        public Task<int> DeleteItemAsync(TItem item)
        {
            return Database.DeleteAsync(item);
        }
    }
}
