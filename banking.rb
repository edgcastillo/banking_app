class Person
	attr_accessor :client_name, :cash_amount

	def initialize(client_name, cash_amount)
		@client_name = client_name
		@cash_amount = cash_amount
		puts "Hi, #{@client_name}. You have $#{@cash_amount}"
	end

end


class Bank
	attr_accessor :bank, :account_balance, :bank_capital

	def initialize(bank, account_balance=0, bank_capital=0)
		@bank = bank 
		@account_balance = account_balance  
		@bank_capital = bank_capital
		@record_client_account = Hash.new
		puts "#{@bank} bank was just created."
	end

	def open_account(customer)
		@record_client_account[customer] = account_balance #hash with customer info and initial account balance of $0 is created
	end

	def deposit(customer, deposit_amount)
		if(customer.cash_amount < deposit_amount) #if desposit amount is bigger than current cash amount
			puts "#{customer.client_name} does not have enough cash to deposit $#{deposit_amount}"
		elsif(@record_client_account.has_key?(customer)) #this compares if the key in the record is the same as the customer info
			@record_client_account[customer] += deposit_amount #add deposit amount to account balance
			self.bank_capital += deposit_amount #add deposit amount to bank assets
			customer.cash_amount -= deposit_amount #substract deposit amount from customer's cash amount
			print "#{customer.client_name} desposited $#{deposit_amount} to #{@bank}. " 
			print "#{customer.client_name} has $#{customer.cash_amount}. " 
			print "#{customer.client_name}'s account has $#{@record_client_account[customer]}\n"
		end
	end

	def withdraw(customer, withdraw_amount)
		if(@record_client_account[customer] < withdraw_amount) #if withdraw amount is bigger than customer's account balance in that account
			puts "#{customer.client_name} does not have enough money in the account to withdraw $#{withdraw_amount}"
		elsif(@record_client_account.has_key?(customer)) #this compares if the key in the record is the same as the customer info
			@record_client_account[customer] -= withdraw_amount #withdraw amount from customer's account balance
			self.bank_capital -= withdraw_amount #substract amount from bank assets
			customer.cash_amount += withdraw_amount #add amount to customer's cash
			print "#{customer.client_name} withdrew $#{withdraw_amount} from #{@bank}. "
			print "#{customer.client_name} has $#{customer.cash_amount}. "
			print "#{customer.client_name}'s account has $#{@record_client_account[customer]}\n"
		end
	end

	def transfer(customer, to_bank, transfer_amount)
		if(@record_client_account.has_key?(customer)) #if the customer is found in the record
			@record_client_account[customer] -= transfer_amount #current bank will get transfer_amount withdrawn
			self.bank_capital -= transfer_amount #same amount will be retired from the current bank assets
			to_bank.account_balance += transfer_amount #destination bank gets the transfer amount
			to_bank.bank_capital += transfer_amount #destination bank assets gets the transfer amount
			print "#{customer.client_name} transfered $#{transfer_amount} from the #{@bank} account to the #{to_bank.bank} account. "
			print "The #{@bank} account has $#{@record_client_account[customer]} and the #{to_bank.bank} has $#{to_bank.account_balance}\n"
		end
	end

	def total_cash_in_bank
		return "#{@bank} has $#{@bank_capital} in the bank" 
	end
		
end

#the credit card class will create a credit card for the user under the user's bank of choice.
#the user will be able to open a credit line, use the credit card for purchases and cash advances.
#and pay the credit card balance with his/her cash amount from the Person class. 
class Credit < Bank
	attr_accessor :bank, :account_balance

	def initialize(bank, account_balance=0)
		@bank = bank
		@account_balance = account_balance
		@record_client_credit = Hash.new
	end	

	def credit_approved(customer, credit_limit)
		@record_client_credit[customer] = [account_balance, credit_limit] #hash with an array containing the account balance and the credit limit
		puts "#{@bank.bank} has approved a credit limit of #{credit_limit} for customer #{customer.client_name}"
	end

	def use_credit_card(customer, credit_used)
		if(@record_client_credit.has_key?(customer))
			@record_client_credit[customer][0] += credit_used #if the credit card is used the account balance gets the total of the purchase
			print "#{customer.client_name} has charged $#{credit_used} on his credit card. "
			print "#{@bank.bank} credit card current balance is: $#{@record_client_credit[customer][0]}. "
			print "#{@bank.bank} credit limit is: $#{@record_client_credit[customer][1]}\n"
		end

	end

	def pay_credit_card(customer, pay_amount)
		if(@record_client_credit.has_key?(customer))
			@record_client_credit[customer][0] -= pay_amount #customer pay amount to credit card and it gets subtract from the account balance
			customer.cash_amount -= pay_amount #customer is paying from the Person class cash amount
			print "#{customer.client_name} paid $#{pay_amount} to #{@bank.bank} credit card. "
			print "#{customer.client_name} cash amount is: $#{customer.cash_amount}. "
			print "#{@bank.bank} credit card balance is: $#{@record_client_credit[customer][0]}\n"
		end
	end

	 def cash_advance(customer, cash_amount)
	 	if(@record_client_credit.has_key?(customer))
	 		@record_client_credit[customer][0] += cash_amount #customer is using the credit card for cash advance, cash_amount goes to account_balance
	 		customer.cash_amount += cash_amount #Person class cash_amount get the cash_advance from the consumer
	 		print "#{customer.client_name} requested a cash advance of $#{cash_amount} from his credit card at #{@bank.bank} bank. "
	 		print "#{customer.client_name} cash amount is: $#{customer.cash_amount}. "
	 		print "#{customer.client_name} credit card balance is: $#{@record_client_credit[customer][0]}\n"
	 	end
	 end
end

