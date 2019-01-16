require 'journey_log'
require 'journey'
describe JourneyLog do

  let(:entry_station)   { double :station, name: "Waterloo", zone: 1 }
  let(:exit_station)    { double :station, name: "Kings Cross", zone: 1 }
  let(:journey)         { double :journey, entry_station: entry_station }

  describe '#new' do
    it 'should initialize journey_log with an empty journey_history array' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#journey_log start' do
    it 'should start a new journey' do
      subject.start(entry_station)

      expect(journey.entry_station).to eq entry_station
    end
  end

end
