require './xyz_service'

describe XYZService do
  let(:target) { mock }

  context "#xyz_filename" do
    before do
      target.stub(:publish_on).and_return(Time.new 2013, 03, 20)
      target.stub(:xyz_category_prefix).and_return("xyz")
      target.stub(:kind).and_return("kind_of_target")
      target.stub(:personal?).and_return(true)
      target.stub(:age) { 23 }
      target.stub(:id) { 123 }
      target.stub(:title) { "09 TARGET @ title" }
    end

    it "returns a  xyz filename" do
      XYZService.xyz_filename(target).should match /20xyzkindoftarget_023_123_.{8}_targettitl\.jpg$/
    end

  end
end
