namespace NewsDB.Model
{
    using System.Data.Entity;

    public class NewsEntities : DbContext
    {
        public NewsEntities() : base("NewsDB")
        {
        }

        public DbSet<News> News { get; set; }
    }
}
