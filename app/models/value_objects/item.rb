class ValueObjects::Item
  attr_reader :item_id, :count
  def initialize(item_id, count)
    @item_id = item_id
    @count = count
  end
end
