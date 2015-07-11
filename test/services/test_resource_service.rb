class ResourceServiceTest < ActiveSupport::TestCase
  test "current_count" do
    resource = Resource.find_by(id: 1)
    resource_keeper = ResourceKeeper.new(
      id: 1,
      target_id: 2,
      current_count: 1,
      last_recovered_at: nil,
    )

    resource_service = ResourceService.new(resource, resource_keeper)
    assert_equal(1, resource_service.current_count)

    resource_service.save
  end
end
