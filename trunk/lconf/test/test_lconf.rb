require 'test/unit'
require 'lconf'
require 'yaml'

class TestConfig < Test::Unit::TestCase
	def testConfig_new
		cfg=Config.new('test')
		assert File.directory?(cfg.name)
	end
	def testGlobalConfig_new
		cfg=GlobalConfig.new('test')
		assert File.directory?(cfg.name)
	end
	def testLocalConfig_new
		cfg=LocalConfig.new('test')
		assert File.directory?(cfg.name)
	end
end

class TestGroup < Test::Unit::TestCase
	def setup
		@cfg=Config.new('test')
	end

	def testGroup_new
		grp=Group.new(@cfg,'test2')
		assert File.directory?(@cfg.name)
	end

	def testGroup_searchGroup
		n=0
		assert_nothing_raised { 
			@cfg.searchGroup(/test2/) {|i| n+=1}
		}
		assert_equal(n,1)
	end

	def testGroup_searchOption
		assert_nothing_raised {
			@cfg.searchOption(/not_here/) { }
		}
	end

	def testGroup_Group_exist?
		assert(Group.exist?(@cfg))
	end

	def testGroup_delete!
		assert_nothing_raised { @cfg.delete! }
	end
end
class TestOption < Test::Unit::TestCase
	class TestObject
		attr_reader :value, :value2
		def initialize
			@value='foo'
			@value2='bar'
		end
	end

	def setup
		@cfg=Config.new('test')
	end
	def teardown
		@cfg.delete!
	end
	def testOption_new1
		option=Option.new(@cfg,'foo','bar')
		value=YAML.load(File.open(option.name))
		assert_equal(value,'bar')
	end
	def testOption_new2
		opt=Option.new(@cfg,'test',TestObject.new())
		assert_equal(opt.value.value,'foo')
		assert_equal(opt.value.value2,'bar')
	end
	
	def testOption_Option_open
		opt=Option.new(@cfg,'test',TestObject.new())
		assert_equal(Option.open(@cfg,'test').value.value,'foo')
		assert_equal(Option.open(@cfg,'test').value.value2,'bar')
	end		
	#--
	# no test for Option#write yet ...

	def testOption_exist?
		opt=Option.new(@cfg,'test2','bla')
		assert_equal(true,Option.exist?(@cfg,'test2'))
	end
	def testOption_delete!
		opt=Option.new(@cfg,'test',0)
		assert_nothing_raised { opt.delete! }
	end
end
