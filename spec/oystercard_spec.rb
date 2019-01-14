require 'oystercard'

describe Oystercard do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}



  it "should have a balance of 0 by default" do
    expect(subject.balance).to eq 0
  end

  it "can be topped up" do
    subject.top_up(50)
    expect(subject.balance).to eq 50
  end

  it 'deducts fare from my card' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.balance).to eq 9
  end

  describe "maximum balance" do
    it "can't be topped up above maximum balance from initiation" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{subject.top_up(1)}.to raise_error "can't top up above #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe "Card status" do
    let (:card_with_balance) {Oystercard.new(10)}
    let (:card_with_one_journey) {card_with_balance.touch_in(entry_station); card_with_balance.touch_out(exit_station); card_with_balance}

    it "starts off not in journey" do
      expect(subject).not_to be_in_journey
    end
    it 'should allow touch in to take an argument' do
      card_with_balance.touch_in(entry_station)
      expect(card_with_balance.entry_station).to eq entry_station
    end
    it "changes status to in journey when touching in" do
      card_with_balance.touch_in(entry_station)
      expect(card_with_balance).to be_in_journey
    end
    it "changes status to not in journey when touching out" do
      expect(card_with_one_journey).not_to be_in_journey
    end
    it "should reset the entry station to nil when touching out" do
      expect(card_with_one_journey.entry_station).to eq nil
    end

    it "should store exit station" do
      expect(card_with_one_journey.exit_station).to eq exit_station
    end

    it "shouldn't be able to touch in if balance is below minimum balance" do
      subject.top_up(Oystercard::MINIMUM_BALANCE - 0.01)
      expect{subject.touch_in(entry_station)}.to raise_error "can't touch in if balance less than #{Oystercard::MINIMUM_BALANCE}"
    end
    it 'should deduct minimum balance when touching out' do
      expect {card_with_balance.touch_out(exit_station)}.to change{card_with_balance.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end

end
