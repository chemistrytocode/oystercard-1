require 'oystercard'

describe Oystercard do
  it "should have a balance of 0 by default" do
    expect(subject.balance).to eq 0
  end

  it "can be topped up" do
    subject.top_up(50)
    expect(subject.balance).to eq 50
  end

  it 'deducts fare from my card' do
    subject.top_up(10)
    subject.deduct(5)
    expect(subject.balance).to eq 5
  end

  describe "maximum balance" do
    it "can't be topped up above maximum balance from initiation" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{subject.top_up(1)}.to raise_error "can't top up above #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe "Card status" do
    it "starts off not in journey" do
      expect(subject).not_to be_in_journey
    end
    it "changes status to in journey when touching in" do
      subject.top_up(2)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "changes status to not in journey when touching out" do
      subject.top_up(2)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it "shouldn't be able to touch in if balance is below minimum balance" do
      subject.top_up(Oystercard::MINIMUM_BALANCE - 0.01)
      expect{subject.touch_in}.to raise_error "can't touch in if balance less than #{Oystercard::MINIMUM_BALANCE}"
    end
  end

end
