require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station, name: "Waterloo", zone: 1 }
  let(:exit_station) { double :station, name: "Kings Cross", zone: 1 }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  describe 'defaults' do
    it 'should have a balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it 'should have an empty journey_history array' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'should allow the user to top up their oystercard' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it 'should not allow user to top up if the end balance is > Max balance' do
      msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
      subject.top_up(87)
      expect { subject.top_up(5) }.to raise_error msg
    end
  end

  describe '#touch_in' do

    it 'should raise an error if touching in without the minimum balance' do
      msg = 'Cannot touch in: Not enough funds'
      expect { subject.touch_in(entry_station) }.to raise_error msg
    end
  end

  describe '#touch_out' do

    it 'should deduct the fare from the card' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end
  end

  describe '#journey_history' do
    it 'should respond to journeys_history' do
      expect(subject).to respond_to(:journey_history)
    end

    it 'should return a journey array with a journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history[0]).to eq ({entry_station: entry_station, exit_station: exit_station})
    end
  end
end
