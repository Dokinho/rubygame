require_relative "../image_art/Image"

RSpec.describe Image do

  context "Default images" do

    it "should have a PLAYER_DEFAULT image (constant)" do
      expect(subject).to be_const_defined(:PLAYER_DEFAULT)
    end

    it "should have an NPC_DEFAULT iamge (constant)" do
      expect(subject).to be_const_defined(:NPC_DEFAULT)
    end

    it "should have an ENEMY_DEFAULT image (constant)" do
      expect(subject).to be_const_defined(:ENEMY_DEFAULT)
    end

    it "should have a SHOP_DEFAULT image (constant)" do
      expect(subject).to be_const_defined(:SHOP_DEFAULT)
    end

    it "should have a QUESTGIVER_DEFAULT image (constant)" do
      expect(subject).to be_const_defined(:QUESTGIVER_DEFAULT)
    end

  end
end