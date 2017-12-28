using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.Models;
using SQLite;

namespace Shopper.Business.LocalStorage
{
    public class ShopperDatabase
    {
        private SQLiteAsyncConnection Database { get; set; }

        public ShopperDatabase(string dbPath)
        {
            Database = new SQLiteAsyncConnection(dbPath);
            Database.CreateTableAsync<Models.ShoppingItem>().Wait();
        }

        public Task<List<ShoppingItem>> GetItemsAsync()
        {
            return Database.Table<ShoppingItem>().ToListAsync();
        }

        public Task<List<ShoppingItem>> GetItemsNotDoneAsync()
        {
            return Database.QueryAsync<ShoppingItem>("SELECT * FROM [ShoppingItem] WHERE [Done] = 0");
        }

        public Task<ShoppingItem> GetItemAsync(string id)
        {
            return Database.Table<ShoppingItem>().Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<string> SaveItemAsync(ShoppingItem item)
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

        public Task<int> DeleteItemAsync(ShoppingItem item)
        {
            return Database.DeleteAsync(item);
        }
    }
}
