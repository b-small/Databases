namespace ATM
{
    using System;
    using System.Data.SqlClient;
    ﻿using System.Transactions;

    class ATMWithdrawal
    {
        static void Main(string[] args)
        {
            var context = new ATMEntities();
            var card = context.CardAccounts.Find(1);
            PrintCardInfo(card);
            WithdrawMoney(1, 1000);
        }

        private static void WithdrawMoney(int cardId, int moneyToWithdraw)
        {
            using (var transaction = new TransactionScope(
                    TransactionScopeOption.Required,
                    new TransactionOptions { IsolationLevel = IsolationLevel.RepeatableRead }))
            {
                var context = new ATMEntities();
                var card = context.CardAccounts.Find(cardId);

                if (card.CardNumber.Length == 10 && card.CardPIN.Length == 4 && card.CardCash > moneyToWithdraw)
                {
                    card.CardCash = card.CardCash - moneyToWithdraw;
                    context.SaveChangesAsync();
                    transaction.Complete();
                    PrintCardInfo(card);
                }
                else
                {
                    MakeSqlException();
                }
            }
        }

        private static void PrintCardInfo(CardAccount card)
        {
            Console.WriteLine("{0}, {1}, {2}, {3}", card.Id, card.CardNumber, card.CardPIN, card.CardCash);
        }

        static SqlException MakeSqlException()
        {
            SqlException exception = null;
            try
            {
                SqlConnection conn = new SqlConnection(@"Data Source=.;Database=GUARANTEED_TO_FAIL");
                conn.Open();
            }
            catch (SqlException ex)
            {
                exception = ex;
            }
            return (exception);
        }
    }
}
