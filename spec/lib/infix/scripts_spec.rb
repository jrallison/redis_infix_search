require "spec_helper"

module Infix
  describe Scripts do
    describe "#initialize" do
      it "requires a redis client" do
        lambda {
          Scripts.new
        }.should raise_error(ArgumentError)
      end
    end

    describe "#method_missing" do
      let(:scripts) { Scripts.new(Redis.new, "foo") }

      it "runs the script" do
        scripts.index("namespace", "id", "string")
      end

      context "when the script does not exist" do
        it "loads the script" do
          Redis.new.script(:flush)
          scripts.index("namespace", "id", "string")
        end
      end
    end
  end
end
