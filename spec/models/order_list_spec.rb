require 'spec_helper'

describe OrderList do
  let(:game) { FactoryGirl.create(:game) }
  let(:order_list) { FactoryGirl.create(:order_list, state: game.current_state, power: "Power") }
  let(:another_order_list) { FactoryGirl.create(:order_list, state: game.current_state, power: "Power") }

  #it "should not fail with empty orders string" do
  #  FactoryGirl.create(:order_list, orders: "").should be_valid
  #end

  it "should replace old order lists by power" do
    game
    order_list
    another_order_list

    game.current_state.order_lists.where(power: "Power").count.should eq(1)
  end

  it "should progress the game if all players have submitted and confirmed" do
    # TODO if all UNDEFEATED powers have submitted and confirmed
    Game.any_instance.should_receive(:progress_phase!).once

    game.powers.each do |power|
      order_list = FactoryGirl.create(:order_list, state: game.current_state, power: power, confirmed: true)
    end
  end
end
