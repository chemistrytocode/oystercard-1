require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_history, :journey, :touched
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  def initialize(journey = Journey)
    @balance = 0
    @journey_history = []
    @journey = journey.new
    @touched = false
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    deduct if touched
    @touched = true
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    journey.start_journey(station)
  end

  def touch_out(station)
    journey.stop_journey(station)
    add_to_history
    deduct
    @touched = false
    @journey = Journey.new
  end

  def add_to_history
    @journey_history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
  end

  private

  def max_reached?(value)
    balance + value > MAX_BALANCE
  end

  def deduct(value = journey.fare)
    @balance -= value
  end
end
