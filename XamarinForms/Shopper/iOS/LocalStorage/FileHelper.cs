using System;
using System.IO;
using Shopper.Business.LocalStorage;
using Shopper.iOS.LocalStorage;
using Xamarin.Forms;


[assembly:Dependency(typeof(FileHelper))]
namespace Shopper.iOS.LocalStorage
{
    public class FileHelper : iFileHelper
    {
        public string GetLocalFilePath(string filename)
        {
            string docFolder = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
            string libFolder = Path.Combine(docFolder, "..", "Library", "Databases");

            if (!Directory.Exists(libFolder))
            {
                Directory.CreateDirectory(libFolder);
            }

            return Path.Combine(libFolder, filename);
        }
    }
}