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

    public class LocalCouponStore : BaseLocalDataStore<CouponItem>
    {
        public LocalCouponStore() : base(DatabaseProvider.CouponDatabase) { }
    }
}
