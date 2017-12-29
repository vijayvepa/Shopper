using System;
using SQLite;

namespace Shopper.Business.Models
{
    public class BaseItem
    {
        public BaseItem()
        {
        }

        [PrimaryKey]
        public string Id { get; set; }

    }
}
