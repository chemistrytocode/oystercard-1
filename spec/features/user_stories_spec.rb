require 'oystercard'
require 'station'

describe 'user_stories' do
  let(:newcard) { Oystercard.new }
  let(:station) { Station.new('Waterloo', 1) }
  before(:each) do
    newcard.top_up(5)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'should return the new balance after topping up' do
    expect(newcard.balance).to eq(5)
  end

  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card

  it 'should not allow the customer to top up over Maximum balance' do
    msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
    newcard.top_up(82)
    expect { newcard.top_up(5) }.to raise_error msg
  end


  #
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey

  it 'should raise an error if touching in without the minimum balance' do
    msg = 'Cannot touch in: Not enough funds'
    newcard2 = Oystercard.new
    expect { newcard2.touch_in('Waterloo') }.to raise_error msg
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card

  it 'should deduct the minimum fare when completing journey' do
    newcard.touch_in('Waterloo')
    expect { newcard.touch_out('Old St') }.to change { newcard.balance }.by(-1)
  end


  # In order to know where I have been
  # As a customer
  # I want to see all my previous trips

  it 'should return all of the previous trips' do
    newcard.touch_in('Waterloo')
    newcard.touch_out('Kings Cross')
    expect(newcard.journey_history).to eq [{ entry_station: 'Waterloo', exit_station: 'Kings Cross' }]
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in

  it 'should know what zone a station is in' do
    expect(station.zone).to eq 1
    expect(station.name).to eq 'Waterloo'
  end
end
