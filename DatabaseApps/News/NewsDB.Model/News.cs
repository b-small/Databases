namespace NewsDB.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    
    public partial class News
    {
        public int NewsId { get; set; }

        [ConcurrencyCheck]
        public string Content { get; set; }
    }
}
