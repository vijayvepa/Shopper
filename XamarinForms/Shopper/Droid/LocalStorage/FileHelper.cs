using System;
using System.IO;
using Shopper.Business.LocalStorage;
using Shopper.Droid.LocalStorage;
using Xamarin.Forms;

[assembly:Dependency(typeof(FileHelper))]
namespace Shopper.Droid.LocalStorage
{
    public class FileHelper : iFileHelper
    {
        public string GetLocalFilePath(string filename)
        {
            string path = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
            return Path.Combine(path, filename);
        }
    }
}