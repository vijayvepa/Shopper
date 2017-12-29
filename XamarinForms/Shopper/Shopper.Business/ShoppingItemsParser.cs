using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Shopper.Business.Models;
namespace Shopper.Business
{
    public static class ShoppingItemsParser
    {
        public static List<ShoppingItem> Parse(string text)
        {
            var shoppingItems = new List<ShoppingItem>();

            var lines = text.Split(new[] { '\r', '\n' });

            foreach (var line in lines)
            {
                if (string.IsNullOrWhiteSpace(line))
                    continue;

                var properties = line.Split('-');

                if (properties.Length < 2)
                {
                    var item = new ShoppingItem()
                    {
                        Text = line.Trim()
                    };
                    shoppingItems.Add(item);
                    continue;
                }

                var item2 = new ShoppingItem()
                {
                    Text = properties[0].Trim(),
                    Store = properties[1].Trim()
                };
                shoppingItems.Add(item2);
            }
            return shoppingItems;
        }

        public static List<CouponItem> ParseCoupons(string text)
        {
            var couponItems = new List<CouponItem>();

            var lines = text.Split(new[] { '\r', '\n' });

            foreach (var line in lines)
            {
                if (string.IsNullOrWhiteSpace(line))
                    continue;

                var date = GetDate(line);

                var remaining = Regex.Replace(line, date, "");

                var properties = remaining.Split('-');

                if (properties.Length < 2)
                {
                    var item = new CouponItem()
                    {
                        Store = remaining.Trim(),
                        Date = date
                    };
                    couponItems.Add(item);
                    continue;
                }

                var item2 = new CouponItem()
                {
                    Store = properties[0].Trim(),
                    Text = properties[1].Trim(),
                    Date = date
                };
                couponItems.Add(item2);
            }
            return couponItems;
        }

        private static string GetDate(string line)
        {
            var fullDateMatches = Regex.Matches(line, @"\d{1,2}[\/-]\d{1,2}[\/-]\d{2,4}");
            var dateMonthMatches = Regex.Matches(line, @"\d{1,2}[\/-]\d{1,2}");

            if (fullDateMatches.Count > 0)
            {
                return fullDateMatches[0].ToString();
            }
            else if (dateMonthMatches.Count > 0)
            {
                return dateMonthMatches[0].ToString();
            }
            else
            {
                return null;
            }
        }
    }
}
