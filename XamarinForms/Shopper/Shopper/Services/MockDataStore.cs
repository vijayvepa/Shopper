using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Shopper
{
    public class MockDataStore : IDataStore<ShoppingItem>
    {
        List<ShoppingItem> items;

        public MockDataStore()
        {
            items = new List<ShoppingItem>();
            var mockItems = new List<ShoppingItem>
            {
                new ShoppingItem { Id = Guid.NewGuid().ToString(), Text = "Tomatoes", Store="Aldi",  Description="This is an item description." },
                new ShoppingItem { Id = Guid.NewGuid().ToString(), Text = "Dhaniyalu", Store="Indian Store", Description="This is an item description." },
                new ShoppingItem { Id = Guid.NewGuid().ToString(), Text = "Oreck Tune Up", Store="Oreck", Description="This is an item description." },
            };

            foreach (var item in mockItems)
            {
                items.Add(item);
            }
        }

        public async Task<bool> AddItemAsync(ShoppingItem item)
        {
            items.Add(item);

            return await Task.FromResult(true);
        }

        public async Task<bool> UpdateItemAsync(ShoppingItem item)
        {
            var _item = items.Where((ShoppingItem arg) => arg.Id == item.Id).FirstOrDefault();
            items.Remove(_item);
            items.Add(item);

            return await Task.FromResult(true);
        }

        public async Task<bool> DeleteItemAsync(string id)
        {
            var _item = items.Where((ShoppingItem arg) => arg.Id == id).FirstOrDefault();
            items.Remove(_item);

            return await Task.FromResult(true);
        }

        public async Task<ShoppingItem> GetItemAsync(string id)
        {
            return await Task.FromResult(items.FirstOrDefault(s => s.Id == id));
        }

        public async Task<IEnumerable<ShoppingItem>> GetItemsAsync(bool forceRefresh = false)
        {
            return await Task.FromResult(items);
        }
    }
}
