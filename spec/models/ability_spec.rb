require 'rails_helper'
require 'cancan/matchers'


describe Ability do

  context 'regular user' do
    subject { Ability.new(nil) }

    it { is_expected.to be_able_to :read, Page.new(public: true) }
    it { is_expected.to_not be_able_to :read, Page.new }
    it { is_expected.to be_able_to :read, News.new }
    it { is_expected.to_not be_able_to :read, News.new(active: false) }
  end
end
