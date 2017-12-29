using System;
using Shopper.Business.Models;

namespace Shopper.Business.LocalStorage
{
    public class CouponDatabase : BaseDatabase<CouponItem>
    {
        public CouponDatabase(string dbPath) : base(dbPath)
        {
        }
    }
}
