using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.LocalStorage;
using Shopper.Business.Models;
using Shopper.Services;
using Xamarin.Forms;

[assembly: Dependency(typeof(LocalCouponStore))]
namespace Shopper.Services
{
    
    public class LocalCouponStore : IDataStore<CouponItem>
    {
        public async Task<bool> AddItemAsync(CouponItem item)
        {
            var result = await DatabaseProvider.CouponDatabase.SaveItemAsync(item);
            item.Id = result;

            return true;
        }

        public async Task<bool> UpdateItemAsync(CouponItem item)
        {
            await DatabaseProvider.CouponDatabase.SaveItemAsync(item);
            return true;
        }

        public Task<bool> DeleteItemAsync(CouponItem item)
        {
            DatabaseProvider.CouponDatabase.DeleteItemAsync(item);
            return Task.FromResult(true);
        }

        public Task<CouponItem> GetItemAsync(string id)
        {
            return DatabaseProvider.CouponDatabase.GetItemAsync(id);
        }

        public Task<List<CouponItem>> GetItemsAsync(bool forceRefresh = false)
        {
            return DatabaseProvider.CouponDatabase.GetItemsAsync();
        }
    }
}
