
class Oystercard

MINIMUM_BALANCE = 1
MAXIMUM_BALANCE = 90
attr_reader :balance, :MAXIMUM_BALANCE, :entry_station

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "can't top up above #{MAXIMUM_BALANCE}" if amount + @balance >  MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "can't touch in if balance less than #{MINIMUM_BALANCE}" unless got_money?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def got_money?
    balance >= MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
