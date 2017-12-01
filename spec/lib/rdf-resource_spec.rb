# ::RDFResource module specs

describe ::RDFResource do
  describe '.configuration' do
    it 'should be a configuration object' do
      expect(described_class.configuration).to be_a_kind_of ::RDFResource::Configuration
    end
  end

  describe '#configure' do
    before :each do
      ::RDFResource.configure do |config|
        config.debug = true
      end
    end
    it 'returns a hash of options' do
      config = ::RDFResource.configuration
      expect(config).to be_instance_of ::RDFResource::Configuration
      expect(config.debug).to be_truthy
    end
    after :each do
      ::RDFResource.reset
    end
  end

  describe '.reset' do
    before :each do
      ::RDFResource.configure do |config|
        config.debug = true
      end
    end
    it 'resets the configuration' do
      ::RDFResource.reset
      config = ::RDFResource.configuration
      expect(config).to be_instance_of ::RDFResource::Configuration
      expect(config.debug).to be_falsey
    end
    after :each do
      ::RDFResource.reset
    end
  end
end
