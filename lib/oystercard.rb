require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :journey_log
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  def initialize(journey = JourneyLog)
    @balance = 0
    @journey_log = journey.new
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    deduct unless @journey_log.journey.entry_station.nil?
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    journey_log.start(station)
  end

  def touch_out(station)
    journey_log.finish(station)
    # add_to_history
    deduct
    journey_log.current_journey
  end

  # def add_to_history
  #   @journey_history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
  # end

  # methods : journey_log_start, journey_log_finish, journeys(returns journey history array)

  private

  def max_reached?(value)
    balance + value > MAX_BALANCE
  end

  def deduct(value = journey_log.price)
    @balance -= value
  end
end
