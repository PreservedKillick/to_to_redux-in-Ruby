require './lib/tasks'
require './lib/lists'

system "clear"
def main_menu
  system "clear"
  puts "\e[94mPress 'a' to add a list"
  puts "Press 'l' to list all of your lists."
  puts "Press 'x' to exit.\e[0m"
  main_choice = gets.chomp
  if main_choice == 'a'
    system "clear"
    add_list
  elsif main_choice == 'l'
    system "clear"
    list_lists
  elsif main_choice == 'x'
    system "clear"
    puts "Good-bye!\n"
    exit
  else
    system "clear"
    puts "\e[91mSorry, that wasn't a valid option.\e[0m"
    main_menu
  end
end

def add_list
  puts "\e[94mEnter name of the new list:\e[0m"
  list_name = gets.chomp
  created_list = List.create(list_name)
  puts "\e[92mList added.\n\n\e[0m"
  list_index = List.all.rindex(created_list)
  add_task(list_index)
end

def list_lists
  system "clear"
  List.all.each_with_index do |list, index|
    puts (index + 1).to_s + ". " + List.all[index].list_name
  end
  puts "\e[94m\nSelect list number to go to list"

  new_list_index = gets.chomp.to_i - 1
  system "clear"
  list_tasks(new_list_index)
end

def list_tasks(list_index)
  system "clear"
  puts "\e[94mHere are all of your tasks:\e[0m"
  List.all[list_index].tasks.each_with_index do |task, index|
    puts (index + 1).to_s + ". " + List.all[list_index].tasks[index]
  end
  puts "\e[94mPress 'a' to add another task to your list."
  puts "Press 'd' to delete a done task off your list."
  puts "Press 'm' to go back to the main menu.\e[0m"
  task_choice = gets.chomp
  if task_choice == 'a'
    add_task(list_index)
  elsif task_choice == 'd'
    delete_task(list_index)
  elsif task_choice == 'm'
    main_menu
  else
    system "clear"
    puts "\e[91mSorry, that wasn't a valid option.\e[0m"
    list_tasks(list_index)
  end
end

def add_task(list_index)
  puts "\e[94mEnter a description of the new task:\e[0m"
  user_description = gets.chomp
  List.all[list_index].add_task(user_description)
  puts "\e[92mTask added.\n\n"
  list_tasks(list_index)
end

def delete_task(list_index)
  system "clear"
  puts "\e[94mEnter the number of the task you would like to delete from your list.\e[0m"
  List.all[list_index].tasks.each_with_index do |task, index|
    puts (index + 1).to_s + ". " + List.all[list_index].tasks[index]
  end
  puts "\n"
  delete_choice = gets.chomp.to_i - 1
  List.all[list_index].tasks.each_with_index do |task, index|
    if index == delete_choice
      List.all[list_index].task_done(delete_choice)
    end
  end
  list_tasks(list_index)
end

main_menu
