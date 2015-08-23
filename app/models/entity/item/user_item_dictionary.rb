# UserItemのDictionaryなクラス
class Entity::Item::UserItemDictionary
  def initialize
    @dictionary = {}
  end

  def get(key)
    return @dictionary[key]
  end

  def add(key, user_item)
    fail key + ' is already registered' if @dictionary.key?(key)

    @dictionary[key] = user_item
  end

  def remove(key)
    fail 'dictionary has not ' + key unless @dictionary.key?(key)

    @dictionary.delete(key)
  end
end

