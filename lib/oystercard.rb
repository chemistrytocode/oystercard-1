
class Oystercard

MAXIMUM_BALANCE = 90
attr_reader :balance, :MAXIMUM_BALANCE

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(amount)
    fail "can't top up above #{MAXIMUM_BALANCE}" if amount + @balance >  MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end

  def in_journey?
    @status
  end

end
