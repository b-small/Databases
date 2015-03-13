namespace Ads
{
    using System;
    using System.Linq;
    using System.Data.Entity;
    using System.Diagnostics;

    class DataShower
    {
        public static void Main(string[] args)
        {
            //ListAllAdsNoInclude();
            //ListAllAdsWithInclude();
            //GetFilteredAdsNotOptimized();
            //GetFilteredAdsOptimized();
            GetAllAdsThenTitles();
            Console.WriteLine();
            GetOnlyAdTitles();

        }

        public static void ListAllAdsNoInclude()
        {
            AdsDbContext context = new AdsDbContext();

            foreach (var ad in context.Ads)
            {
                var status = (ad.AdStatus == null ? "no stats" : ad.AdStatus.Status);
                var cat = (ad.Category == null ? "no category" : ad.Category.Name);
                var town = (ad.Town == null ? "no town" : ad.Town.Name);

                Console.WriteLine("{0}, {1}, {2}, {3}, {4}", ad.Title, status, cat,
                    town, ad.AspNetUser.Name);
            }
        }

        public static void ListAllAdsWithInclude()
        {
            AdsDbContext context = new AdsDbContext();

            foreach (var ad in context.Ads
                .Include(ad => ad.AdStatus)
                .Include(ad => ad.Town)
                .Include(ad => ad.Category)
                .Include(ad => ad.AspNetUser))
            {
                var status = (ad.AdStatus == null ? "no stats" : ad.AdStatus.Status);
                var cat = (ad.Category == null ? "no category" : ad.Category.Name);
                var town = (ad.Town == null ? "no town" : ad.Town.Name);

                Console.WriteLine("{0}, {1}, {2}, {3}, {4}", ad.Title, status, cat,
                    town, ad.AspNetUser.Name);
            }
        }

        public static void GetFilteredAdsNotOptimized()
        {
            AdsDbContext context = new AdsDbContext();

            var ads = context.Ads
                .OrderBy(a => a.Date)
                .ToList()
                .Where(a => a.AdStatus.Status == "Published")
                .Select(a => new { a.Title, a.Category, a.Town })
                .ToList();


            foreach (var ad in ads)
            {
                var cat = (ad.Category == null ? "no category" : ad.Category.Name);
                var town = (ad.Town == null ? "no town" : ad.Town.Name);

                Console.WriteLine("{0}, {1}, {2}", ad.Title, cat, town);
            }
        }


        public static void GetFilteredAdsOptimized()
        {
            AdsDbContext context = new AdsDbContext();

            var ads = context.Ads
                .Where(a => a.AdStatus.Status == "Published")
                .OrderBy(a => a.Date)
                .Select(a => new { a.Title, a.Category, a.Town })
                .ToList();

            foreach (var ad in ads)
            {
                var cat = (ad.Category == null ? "no category" : ad.Category.Name);
                var town = (ad.Town == null ? "no town" : ad.Town.Name);

                Console.WriteLine("{0}, {1}, {2}", ad.Title, cat, town);
            }
        }

        public static void GetAllAdsThenTitles()
        {
            AdsDbContext context = new AdsDbContext();
            var watch = Stopwatch.StartNew();

            var ads = context.Ads;

            foreach (var ad in ads)
            {
                Console.WriteLine("{0}", ad.Title);
            }

            watch.Stop();
            var elapsedTime = watch.Elapsed;

            Console.WriteLine("\nTime: {0}\nwithout optimization", elapsedTime);
        }

        public static void GetOnlyAdTitles()
        {
            AdsDbContext context = new AdsDbContext();

            var watch = Stopwatch.StartNew();

            var adsTitles = context.Ads
                .Select(a => a.Title);

            foreach (var title in adsTitles)
            {
                Console.WriteLine(title);
            }

            watch.Stop();
            var elapsedTime = watch.Elapsed;
            Console.WriteLine("\nTime: {0}\nwith optimization", elapsedTime);
        }
    }
}
