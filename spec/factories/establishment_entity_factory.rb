RSpec.describe EstablishmentEntityFactory do
  it 'constructor' do
    establishment_entity_factory = EstablishmentEntityFactory.new
    expect(establishment_entity_factory).to be_an_instance_of(EstablishmentEntityFactory)
  end
end

