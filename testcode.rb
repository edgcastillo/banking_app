require_relative 'banking'


chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)
chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)
chase.transfer(me, wells_fargo, 100)

#challenge Level 1
chase.deposit(me, 5000)
chase.withdraw(me, 5000)

#challenge Level 2
puts chase.total_cash_in_bank
puts wells_fargo.total_cash_in_bank

#challenge Level 3
chase_credit = Credit.new(chase)
wells_fargo_credit = Credit.new(wells_fargo)
chase_credit.credit_approved(me, 5000)
chase_credit.credit_approved(friend1, 5000)
chase_credit.use_credit_card(me, 100)
chase_credit.use_credit_card(friend1, 200)
wells_fargo_credit.credit_approved(me, 3000)
wells_fargo_credit.credit_approved(friend1, 2000)
wells_fargo_credit.use_credit_card(me, 500)
wells_fargo_credit.use_credit_card(friend1, 1000)
chase_credit.pay_credit_card(me, 50)
wells_fargo_credit.pay_credit_card(friend1, 250)
chase_credit.cash_advance(me, 250)

