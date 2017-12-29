using System;
using Xamarin.Forms;

namespace Shopper.Business.LocalStorage
{
    public static class DatabaseProvider
    {
        static ShopperDatabase _database;
        static CouponDatabase _couponDatabase;

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

        public static CouponDatabase CouponDatabase
        {
            get
            {
                if (_couponDatabase == null)
                {
                    _couponDatabase = new CouponDatabase(DependencyService.Get<iFileHelper>().GetLocalFilePath("CouponSQLite.db3"));
                }

                return _couponDatabase;
            }
        }
    }
}
