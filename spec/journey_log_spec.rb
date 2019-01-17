require 'journey_log'
require 'journey'
describe JourneyLog do

  let(:entry_station)   { double :station, name: "Waterloo", zone: 1 }
  let(:exit_station)    { double :station, name: "Kings Cross", zone: 1 }
  let(:journey_class)   { double :journey_class, new: journey }
  let(:journey)         { double :journey, entry_station: entry_station, exit_station: exit_station }

  describe '#new' do
    it 'should initialize journey_log with an empty journey_history array' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#journey_log start' do
    it 'should start a new journey' do
      subject.start(entry_station)
      expect(subject.journey.entry_station).to eq entry_station
    end
  end

  describe '#journey_log finish' do
    it 'should finish a journey at the specified station' do
      subject.finish(exit_station)
      expect(subject.journey.exit_station).to eq exit_station
    end
  end

  describe '#add_to_history' do
    it 'should add a journey to the journey history array' do
      jlog = JourneyLog.new(journey_class)
      jlog.add_to_history
      expect(jlog.journey_history).to include ({:entry_station=>entry_station, :exit_station=>exit_station})
    end
  end
end
