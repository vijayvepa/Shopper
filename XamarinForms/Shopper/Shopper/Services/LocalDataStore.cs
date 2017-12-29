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
    public class LocalDataStore : BaseLocalDataStore<ShoppingItem>
    {
        public LocalDataStore() : base(DatabaseProvider.Database) { }
    }
}
