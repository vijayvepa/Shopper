using System.Collections.Generic;
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
    }
}
