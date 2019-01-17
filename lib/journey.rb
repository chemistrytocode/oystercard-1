class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    @entry_station = station
  end

  def stop_journey(station)
    @exit_station = station
  end

  def fare
    return PENALTY_CHARGE if incomplete_journey?
    STANDARD_CHARGE
  end

  def incomplete_journey?
    entry_station.nil? || exit_station.nil?
  end
end

  private

  STANDARD_CHARGE = 1
  PENALTY_CHARGE = 6


# card = Osyercard.new
#           Journey.new
# card.top_up(10)
# station = Station.new
# card.touch_in(station)
#     journey.start_journey
# card.touch_out(station)
#     journey.stop_journey
#     deduct
