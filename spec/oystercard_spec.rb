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
end
