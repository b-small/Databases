namespace NewsDB
{
    using System;
    using System.Linq;
    using System.Data.Entity;
    using Model;
    using Model.Migrations;
    using System.Data.Entity.Infrastructure;

    public class Updates
    {
        static void Main(string[] args)
        {

            Database.SetInitializer(new MigrateDatabaseToLatestVersion<NewsEntities, Configuration>());

            var firstContext = new NewsEntities();

            var end = false;
            var isSaved = false;

            Console.WriteLine("Application started");
            var newsContentToPrint = firstContext.News.FirstOrDefault(n => n.NewsId == 1);

            Console.WriteLine("Text from DB: " + newsContentToPrint.Content);
            Console.WriteLine("Enter the new content: ");

            newsContentToPrint.Content = Console.ReadLine();

            Console.WriteLine("Application started");

            while (!end)
            {
                var secondContext = new NewsEntities();
                var newsContentToPrintTwo = secondContext.News.FirstOrDefault(n => n.NewsId == 1);
                Console.WriteLine("Enter the new content: ");
                Console.WriteLine("Text from DB: " + newsContentToPrintTwo.Content);
                newsContentToPrintTwo.Content = Console.ReadLine();

                try
                {
                    if (!isSaved)
                    {
                        firstContext.SaveChanges();
                        isSaved = true;
                    }

                    secondContext.SaveChanges();
                    Console.WriteLine("Update successful");
                    end = true;
                }
                catch (DbUpdateConcurrencyException)
                {
                    Console.WriteLine("Concurrency error ocurred!");
                    end = false;
                }
            }
        }
    }
}
