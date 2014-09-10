require 'rails_helper'

describe Ability do
  subject { Ability.new(User.new) }

  context 'regular user' do
    it { should_not be_able_to :read, Page.new(public: true) }
  end
end
