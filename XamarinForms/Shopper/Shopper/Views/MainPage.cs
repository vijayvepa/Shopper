using System;
using Shopper.Views;
using Xamarin.Forms;
using XamarinForms.Extensions.Controls;

namespace Shopper
{
    public class MainPage : TabbedPage
    {
        private const string Today = "Today";
        private const string Setup = "Setup";
        private const string History = "History";
        private Checkbox Checkbox1 { get; set; }

        private const string AboutPageIcon = "tab_about.png";
        private const string FeedIcon = "tab_feed.png";

        public MainPage()
        {
            Page todayPage, setupPage, historyPage;

            switch (Device.RuntimePlatform)
            {
                case Device.iOS:
                    todayPage = new NavigationPage(new TodayPage()) {Title = Today, Icon = FeedIcon};
                    historyPage = new NavigationPage(new HistoryPage()) {Title = History, Icon = FeedIcon};
                    setupPage = new NavigationPage(new SetupPage()) {Title = Setup, Icon = AboutPageIcon};
                    break;

                default:
                    todayPage = new TodayPage() {Title = Today};
                    historyPage = new HistoryPage() {Title = History};
                    setupPage = new SetupPage() {Title = Setup};
                    break;
            }

            Children.Add(todayPage);
            Children.Add(historyPage);
            Children.Add(setupPage);

            Title = Children[0].Title;
        }

        protected override void OnCurrentPageChanged()
        {
            base.OnCurrentPageChanged();
            Title = CurrentPage?.Title ?? string.Empty;
        }
    }
}