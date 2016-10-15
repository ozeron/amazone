require 'rails_helper'

describe ProductInformationLoader do
  subject { ProductInformationLoader.new(asin) }
  let(:xml_response) { Nokogiri::XML(xml) }

  before do
    allow(subject).to receive(:perform_request) { xml_response }
  end

  context 'ASIN valid' do
    let(:asin) { 'B00OQVZDJM ' }
    let(:xml) do
      '<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2013-08-01"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="Jeff/1.5.1 (Language=Ruby; MBPro13Lapchenko)"></Header></HTTPHeaders><RequestId>9f01648e-223b-4519-8e57-c12139bd4c96</RequestId><Arguments><Argument Name="AWSAccessKeyId" Value="AKIAIGXBH3XTSVOR7UNQ"></Argument><Argument Name="AssociateTag" Value="associatesidt-20"></Argument><Argument Name="ItemId" Value="B00OQVZDJM"></Argument><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="SignatureMethod" Value="HmacSHA256"></Argument><Argument Name="SignatureVersion" Value="2"></Argument><Argument Name="Timestamp" Value="2016-10-15T12:47:30Z"></Argument><Argument Name="Version" Value="2013-08-01"></Argument><Argument Name="Signature" Value="h7BDh5s2V+mQtY9KcMKRbmVoEy3uVlfYbf4MPF9jUAQ="></Argument></Arguments><RequestProcessingTime>0.0092489710000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><IdType>ASIN</IdType><ItemId>B00OQVZDJM</ItemId><ResponseGroup>Small</ResponseGroup><VariationPage>All</VariationPage></ItemLookupRequest></Request><Item><ASIN>B00OQVZDJM</ASIN><ParentASIN>B00U87A5FU</ParentASIN><DetailPageURL>http://www.amazon.com/Amazon-Kindle-Paperwhite-6-Inch-4GB-eReader/dp/B00OQVZDJM%3Fpsc%3D1%26SubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB00OQVZDJM</DetailPageURL><ItemLinks><ItemLink><Description>Technical Details</Description><URL>http://www.amazon.com/Amazon-Kindle-Paperwhite-6-Inch-4GB-eReader/dp/tech-data/B00OQVZDJM%3FSubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>Add To Baby Registry</Description><URL>http://www.amazon.com/gp/registry/baby/add-item.html%3Fasin.0%3DB00OQVZDJM%26SubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>Add To Wedding Registry</Description><URL>http://www.amazon.com/gp/registry/wedding/add-item.html%3Fasin.0%3DB00OQVZDJM%26SubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>Add To Wishlist</Description><URL>http://www.amazon.com/gp/registry/wishlist/add-item.html%3Fasin.0%3DB00OQVZDJM%26SubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>Tell A Friend</Description><URL>http://www.amazon.com/gp/pdp/taf/B00OQVZDJM%3FSubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>All Customer Reviews</Description><URL>http://www.amazon.com/review/product/B00OQVZDJM%3FSubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink><ItemLink><Description>All Offers</Description><URL>http://www.amazon.com/gp/offer-listing/B00OQVZDJM%3FSubscriptionId%3DAKIAIGXBH3XTSVOR7UNQ%26tag%3Dassociatesidt-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB00OQVZDJM</URL></ItemLink></ItemLinks><ItemAttributes><Manufacturer>Amazon</Manufacturer><ProductGroup>Amazon Ereaders</ProductGroup><Title>Kindle Paperwhite E-reader - Black, 6" High-Resolution Display (300 ppi) with Built-in Light, Wi-Fi - Includes Special Offers</Title></ItemAttributes></Item></Items></ItemLookupResponse>'
    end

    let(:result) do
      {
        title: "Kindle Paperwhite E-reader - Black, 6\" High-Resolution Display (300 ppi) with Built-in Light, Wi-Fi - Includes Special Offers",
        manufacturer: "Amazon"
      }
    end

    it 'success after perform' do
      subject.perform!
      expect(subject.succeed?).to be true
    end

    it '#data equal expected hash' do
      subject.perform!
      expect(subject.data).to eq(result)
    end
  end

  context 'ASIN invalid' do
    let(:asin) { 'B00OQ'}
    let(:xml) do
      '<?xml version="1.0" ?><ItemLookupResponse xmlns="http://webservices.amazon.com/AWSECommerceService/2013-08-01"><OperationRequest><HTTPHeaders><Header Name="UserAgent" Value="Jeff/1.5.1 (Language=Ruby; MBPro13Lapchenko)"></Header></HTTPHeaders><RequestId>87580a44-ef24-4dc0-90c9-f2a89b7b0f29</RequestId><Arguments><Argument Name="AWSAccessKeyId" Value="AKIAIGXBH3XTSVOR7UNQ"></Argument><Argument Name="AssociateTag" Value="associatesidt-20"></Argument><Argument Name="ItemId" Value="B00OQ"></Argument><Argument Name="Operation" Value="ItemLookup"></Argument><Argument Name="Service" Value="AWSECommerceService"></Argument><Argument Name="SignatureMethod" Value="HmacSHA256"></Argument><Argument Name="SignatureVersion" Value="2"></Argument><Argument Name="Timestamp" Value="2016-10-15T12:49:05Z"></Argument><Argument Name="Version" Value="2013-08-01"></Argument><Argument Name="Signature" Value="2N5sohwEkY7oLwcsu9cr8XOa/KVg7A/PeCdBQiuQ7Lo="></Argument></Arguments><RequestProcessingTime>0.0048918950000000</RequestProcessingTime></OperationRequest><Items><Request><IsValid>True</IsValid><ItemLookupRequest><IdType>ASIN</IdType><ItemId>B00OQ</ItemId><ResponseGroup>Small</ResponseGroup><VariationPage>All</VariationPage></ItemLookupRequest><Errors><Error><Code>AWS.InvalidParameterValue</Code><Message>B00OQ is not a valid value for ItemId. Please change this value and retry your request.</Message></Error></Errors></Request></Items></ItemLookupResponse>'
    end
    let(:errors) { 'B00OQ is not a valid value for ItemId. Please change this value and retry your request.'}
    let(:result) { {} }

    it 'failed after perform' do
      subject.perform!
      expect(subject.succeed?).to be false
    end

    it '#data equal empty hash' do
      subject.perform!
      expect(subject.data).to eq(result)
    end

    it '#errors present' do
      subject.perform!
      expect(subject.errors).to eq(errors)
    end
  end
end
