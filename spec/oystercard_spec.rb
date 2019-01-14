require 'oystercard'

describe Oystercard do
  it "should have a balance of 0 by default" do
    expect(subject.balance).to eq 0
  end

  it "can be topped up" do
    subject.top_up(100)
    expect(subject.balance).to eq 100
  end
end
