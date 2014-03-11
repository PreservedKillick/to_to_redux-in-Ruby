require 'rspec'
require 'tasks'
require 'lists'

describe Task do
  it 'is initialized with a description' do
    test_task = Task.new('Wash the dishes')
    test_task.should be_an_instance_of Task
  end
  it "lets you read the description out" do
    test_task = Task.new('Wash the dishes')
    test_task.description.should eq "Wash the dishes"
  end
end

describe List do
  before do
    List.clear
  end

  it 'is initialized with a description' do
    test_list = List.new("Chores")
    test_list.should be_an_instance_of List
  end
  it 'adds new tasks to a specified list' do
    test_list = List.new("Chores")
    task_to_add = Task.new("rake")
    test_list.add_task(task_to_add)
    test_list.tasks.should eq [task_to_add]
    test_list.tasks[0].description.should eq "rake"
  end
  describe '.all' do
    it 'is empty at first' do
      List.all.should eq []
    end
  end
  describe '#save' do
    it 'adds a list to the array of saved lists' do
      test_list = List.new("walk")
      test_list.save
      List.all.should eq [test_list]
    end
  end
  describe '.clear' do
    it 'clears the list of lists' do
      List.new("walk").save
      List.clear
      List.all.should eq []
    end
  end
  describe '.create' do
    it 'makes a new instance of a list' do
      test_list = List.create('walk the lion')
      test_list.should be_an_instance_of List
    end
    it 'saves the list' do
      test_list = List.create('walk the lion')
      List.all.should eq [test_list]
    end
  end
end
