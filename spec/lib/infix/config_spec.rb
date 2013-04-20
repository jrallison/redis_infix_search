require "spec_helper"

module Infix
  describe Config do
    describe "#initialize" do
      it "yields itself to a block" do
        config = Config.new do |c|
          c.namespace = "x"
        end
        config.namespace.should == "x"
      end
    end

    it "allows setting of redis connection options" do
      Config.new do |config|
        config.redis = { host: "127.0.0.1", port: 6379 }
      end
    end

    it "allows setting of redis namespace" do
      config = Config.new do |config|
        config.namespace = "ns"
      end

      config.namespace.should == "ns"
    end
  end
end
