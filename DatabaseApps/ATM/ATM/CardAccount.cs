namespace ATM
{
    using System;
    using System.Collections.Generic;
    
    public partial class CardAccount
    {
        public int Id { get; set; }
        public string CardNumber { get; set; }
        public string CardPIN { get; set; }
        public Nullable<decimal> CardCash { get; set; }
    }
}
