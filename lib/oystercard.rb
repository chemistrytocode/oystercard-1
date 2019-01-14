
class Oystercard

MAXIMUM_BALANCE = 90
attr_reader :balance, :MAXIMUM_BALANCE

  def initialize
  @balance = 0
  end

  def top_up(amount)
    fail "can't top up above #{MAXIMUM_BALANCE}" if amount + @balance >  MAXIMUM_BALANCE 
    @balance += amount
  end
end
