namespace Ads
{
    using System.Data.Entity;

    public partial class AdsDbContext : DbContext
    {
        public AdsDbContext() :
            base("name=AdsEntities")
        {
            
        }

        public virtual DbSet<Ad> Ads { get; set; }

    }
}
