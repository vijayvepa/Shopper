using System;
using Xamarin.Forms;

namespace Shopper.Business.LocalStorage
{
    public static class DatabaseProvider
    {
        static ShopperDatabase _database;

        public static ShopperDatabase Database
        {
            get
            {
                if (_database == null)
                {
                    _database = new ShopperDatabase(DependencyService.Get<iFileHelper>().GetLocalFilePath("ShopperSQLite.db3"));
                }

                return _database;
            }
        }
    }
}
