require 'oystercard'

describe Oystercard do

  describe 'balance' do

    it 'responds to balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'balance is 0 on creation' do
      expect(subject.balance).to eq(0)
    end

  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it '#top_up will increase balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error "Error: Maximum balance cannot be more than £#{max_balance}"
    end
  end

  describe '#deduct' do

    it 'deducts 5 from the card balance' do
      expect { subject.deduct(5) }.to change { subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it '#in_journey? returns boolean' do
      expect(subject.in_journey?).to be(true).or be(false)
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  context 'touched_in' do

    before(:all) do
      @card = Oystercard.new
      @card.touch_in
    end

    describe '#touch_in' do

      it '#touch_in sets @in_journey true' do
        expect(@card).to be_in_journey
      end

    end

    describe '#touch_out' do

      it { is_expected.to respond_to(:touch_out) }

      it '#touch_out sets @in_journey false' do
        @card.touch_out
        expect(@card.in_journey?).to be false
      end

    end
  end

end
