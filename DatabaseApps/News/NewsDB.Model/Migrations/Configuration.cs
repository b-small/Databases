namespace NewsDB.Model.Migrations
{
    using System.Collections.Generic;
    using System.Data.Entity.Migrations;
    using System.Linq;

    public sealed class Configuration : DbMigrationsConfiguration<NewsEntities>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
        }

        protected override void Seed(NewsEntities context)
        {
            var db = new NewsEntities();

            var news = new List<News>
            {
                new News
                {
                    Content = @"The first news ever"
                },
                new News
                {
                    Content = "EF 7 Beta To Be Released in May 2016"
                }

            };



            news.ForEach(delegate(News n)
            {
                if (!db.News.Any(x => n.Content == x.Content))
                {
                    db.News.AddOrUpdate(n);
                }

            });

            db.SaveChanges();

        }
    }
}
