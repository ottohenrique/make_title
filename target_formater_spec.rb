require './xyz_service'
require './target_formater'

describe XYZService::TargetFormater do
  let(:target) { mock }
  let(:formater) { XYZService::TargetFormater.new target }

  before do
    target.stub(:publish_on).and_return(Time.new 2013, 03, 20)
    target.stub(:xyz_category_prefix).and_return("xyz")
    target.stub(:kind).and_return("kind_of_target")
    target.stub(:personal?).and_return(true)
    target.stub(:age) { 23 }
    target.stub(:id) { 123 }
    target.stub(:title) { "09 TARGET @ title" }
  end

  context "personal information" do
    context "when true" do
      before do
        target.stub(:personal?) { true }
      end

      context "when age is null"  do
        before do
          target.stub(:age) { nil }
        end

        it "returns 000" do
          formater.age.should == '_000'
        end
      end

      context "when age is reported" do
        before do
          target.stub(:age) { 30 }
        end

        it "returns age padded with 0" do
          formater.age.should == '_030'
        end
      end
    end

    context "when false" do
      before do
        target.stub(:personal?) { false }
      end

      it "returns only _ for separator" do
        formater.age.should == '_'
      end
    end
  end

  context "title" do
    it "removes non alphabetical chars, changes to downcase and crops to 10 chars" do
      target.stub(:title) { "TARGET @ title" }
      formater.title.should == 'targettitl'
    end

    it "removes non alphabetical chars, changes to downcase" do
      target.stub(:title) { "title" }
      formater.title.should == 'title'
    end
  end

  context "published_on" do
    it "returns published_on day 0 padded" do
      target.stub(:publish_on).and_return(Time.new 2012, 1, 1)

      formater.publish_on.should == '01'
    end
  end

  context "other data" do
    it "proxies to target data if not found correspondent method" do
      target.should_receive(:kind)
      formater.kind
    end
  end
end
