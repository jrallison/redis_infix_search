require "spec_helper"

module Infix
  describe Connection do
    let(:connection) { Connection.new(Infix.config) }
    let(:redis)      { Infix.config.redis }

    describe "#index" do
      it "indexes all infixes of length 3 or more" do
        connection.index(1, "hello")

        redis.zrank("match:hel",   "hello:1").should_not be_nil
        redis.zrank("match:ell",   "hello:1").should_not be_nil
        redis.zrank("match:llo",   "hello:1").should_not be_nil
        redis.zrank("match:hell",  "hello:1").should_not be_nil
        redis.zrank("match:ello",  "hello:1").should_not be_nil
        redis.zrank("match:hello", "hello:1").should_not be_nil
      end

      it "removes existing matches when reindexing" do
        connection.index(1, "hello")
        connection.index(1, "world")

        redis.zrank("match:hel",   "hello:1").should be_nil
        redis.zrank("match:ell",   "hello:1").should be_nil
        redis.zrank("match:llo",   "hello:1").should be_nil
        redis.zrank("match:hell",  "hello:1").should be_nil
        redis.zrank("match:ello",  "hello:1").should be_nil
        redis.zrank("match:hello", "hello:1").should be_nil

        redis.zrank("match:wor",   "world:1").should_not be_nil
        redis.zrank("match:orl",   "world:1").should_not be_nil 
        redis.zrank("match:rld",   "world:1").should_not be_nil
        redis.zrank("match:worl",  "world:1").should_not be_nil
        redis.zrank("match:orld",  "world:1").should_not be_nil
        redis.zrank("match:world", "world:1").should_not be_nil
      end
    end

    describe "#search" do
      it "returns all indexed strings that match" do
        connection.index(1, "hello")
        connection.index(2, "helloworld")
        connection.index(3, "world")

        connection.search("ell").should == [
          { id: "1", value: "hello" },
          { id: "2", value: "helloworld" }
        ]
      end

      it "returns documents in lexigraphical order" do
        connection.index(2, "chello")
        connection.index(3, "ahello")
        connection.index(1, "bhello")

        connection.search("hello").should == [
          { id: "3", value: "ahello" },
          { id: "1", value: "bhello" },
          { id: "2", value: "chello" },
        ]
      end

      it "returns exact matches first" do
        connection.index(3, "ahello")
        connection.index(1, "hello")

        connection.search("hello").should == [
          { id: "1", value: "hello" },
          { id: "3", value: "ahello" },
        ]
      end

      it "returns prefix matches prior to infix matches" do
        connection.index(3, "ahello")
        connection.index(1, "ello")

        connection.search("ell").should == [
          { id: "1", value: "ello" },
          { id: "3", value: "ahello" },
        ]
      end
    end
  end
end
