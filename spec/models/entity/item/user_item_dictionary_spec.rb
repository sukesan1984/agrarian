require 'rails_helper'

RSpec.describe Entity::Item::UserItemDictionary do
  it 'UserItemDictionary' do
    user_item_dictionary = Entity::Item::UserItemDictionary.new
    user_item_dictionary.add('hoge', 'fuga')
    expect(user_item_dictionary.get('hoge')).to eq 'fuga'

    user_item_dictionary.remove('hoge')
    expect(user_item_dictionary.get('hoge')).to eq nil
  end
end

