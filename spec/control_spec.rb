require 'spec_helper'

describe FlightControls::Control do
  def get_control ()
    FlightControls::Control.new(
      pin: 1,
      mode: 'INPUT',
      name: 'test',
      channel: 1,
      index: 0
    )
  end

  it 'initializes' do
    control = get_control
    expect(control.pin).to eq(1)
    expect(control.mode).to eq('INPUT')
    expect(control.name).to eq('test')
    expect(control.channel).to eq(1)
    expect(control.index).to eq(0)
  end

  describe 'setting value' do
    context 'for the first time' do
      it 'should return false' do
        control = get_control
        expect(control.set_value(1)).to eq(false)
      end
    end

    context 'when value has changed' do
      it 'should return true' do
        control = get_control
        control.set_value(1)
        expect(control.set_value(2)).to eq(true)
      end
    end

    context 'when value has not changed' do
      it 'should return false' do
        control = get_control
        control.set_value(1)
        expect(control.set_value(1)).to eq(false)
      end
    end
  end
end
