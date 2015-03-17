namespace NewsDB.Model
{
    using System;
    using System.Linq;
    using System.Data.Entity;
    using NewsDB.Model.Migrations;

    class Program
    {
        static void Main(string[] args)
        {
            using (var db = new NewsEntities())
            {

                Database.SetInitializer(new MigrateDatabaseToLatestVersion<NewsEntities, Configuration>());

                var news = db.News.ToList();
                
                foreach (var n in news)
                {
                   Console.WriteLine(n.Content);
                }
            }

        }
    }
}
