require 'cancan/matchers'
require 'spec_helper'

describe "permissions" do
  it "lets a user delete only their own store" do
    user = User.create!(:email => "email@email.com", :password => "password")
    user2 = User.create!(:email => "email2@email.com", :password => "password")
    store = user.stores.create!
    ability = Ability.new(user)
    ability2 = Ability.new(user2)
    ability.should be_able_to(:destroy, store)
    ability2.should_not be_able_to(:destroy, store)
  end

  it "lets a user create an item in their own store" do
    user = User.create!(:email => "email@email.com", :password => "password")
    store = user.stores.create!
    item = store.items.new
    ability = Ability.new(user)
    ability.should be_able_to(:create, item)
  end

  it "doesn't let a user create an item in someone else's store" do
    store_owner = User.create!(:email => "email@email.com", :password => "password")
    store = store_owner.stores.create!
    other_user = User.create!(:email => "another@email.com", :password => "password")
    item = store.items.new
    ability = Ability.new(other_user)
    ability.should_not be_able_to(:create, item)
  end
end
