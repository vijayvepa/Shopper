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

        public Task<ShoppingItem> GetItemAsync(int id)
        {
            return Database.Table<ShoppingItem>().Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public Task<int> SaveItemAsync(ShoppingItem item)
        {
            if (item.Id != 0)
                return Database.UpdateAsync(item);
            else
                return Database.InsertAsync(item);
        }

        public Task<int> DeleteItemAsync(ShoppingItem item)
        {
            return Database.DeleteAsync(item);
        }
    }
}
