require 'journey'

describe Journey do
  let(:start_station) {double :station}
  let(:end_station) {double :station}

  describe '#start_journey' do
    it 'should set entry_station to station' do
      subject.start_journey(start_station)
      expect(subject.entry_station).to eq start_station
    end
  end

  describe '#stop_journey' do
    it 'should set exit station to station' do
      subject.stop_journey(end_station)
      expect(subject.exit_station).to eq end_station
    end
  end

  describe '#fare' do
    it 'should return 6 on incomplete_journey' do
      allow(subject).to receive(:incomplete_journey?) {true}
      expect(subject.fare).to eq 6
    end
    it 'should return 1 on successful_journey' do
      allow(subject).to receive(:incomplete_journey?) {false}
      expect(subject.fare).to eq 1
    end
  end
end
