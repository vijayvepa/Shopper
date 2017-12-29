using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shopper.Business.Models;
using SQLite;

namespace Shopper.Business.LocalStorage
{
    public class ShopperDatabase : BaseDatabase<ShoppingItem>
    {
        public ShopperDatabase(string dbPath) : base(dbPath)
        {
            
        }
    }
}
