module Support
  class XmlParser
    # A parser has to respond to this.
    def self.parse(body)
      new(body)
    end

    attr_reader :body

    def initialize(body)
      @body = Nokogiri::XML(body)
    end

    # Implement parser here.
  end
end
