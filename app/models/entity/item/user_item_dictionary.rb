# UserItemのDictionaryなクラス
class Entity::Item::UserItemDictionary
  def initialize
    @dictionary = {}
  end

  def get(key)
    return @dictionary[key]
  end

  def add(key, user_item)
    if @dictionary.has_key?(key)
      fail key + ' is already registered' 
    end

    @dictionary[key] = user_item
  end

  def remove(key)
    unless @dictionary.has_key?(key)
      fail 'dictionary has not ' + key
    end

    @dictionary.delete(key)
  end
end
